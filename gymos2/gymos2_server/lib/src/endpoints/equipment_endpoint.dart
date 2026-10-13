import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

import '../services/access.dart';

import '../services/notifications.dart';

class EquipmentEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<SocietyEquipment>> list(Session s) async {
    final p = await Access.profile(s);
    return SocietyEquipment.db.find(
      s,
      where: (t) => t.societyId.equals(p.societyId),
      orderBy: (t) => t.label,
    );
  }

  Future<List<EquipmentCatalog>> catalog(Session s) async {
    await Access.profile(s);
    return EquipmentCatalog.db.find(s);
  }

  Future<SocietyEquipment> save(
    Session s,
    int? id,
    int catalogId,
    String label,
    int quantity,
    String status,
    String location,
  ) async {
    final p = await Access.profile(s, admin: true);
    if (quantity < 0 ||
        quantity > 100 ||
        !['available', 'maintenance', 'unavailable'].contains(status)) {
      throw GymException(message: 'Invalid equipment values.');
    }

    if (await EquipmentCatalog.db.findById(s, catalogId) == null) {
      throw GymException(message: 'Equipment type not found.');
    }

    final old = id == null ? null : await SocietyEquipment.db.findById(s, id);
    if (id != null && (old == null || old.societyId != p.societyId)) {
      throw GymException(message: 'Equipment not found.');
    }

    final row = SocietyEquipment(
      id: id,
      societyId: p.societyId,
      equipmentId: catalogId,
      label: Access.text(label, max: 80),
      quantity: quantity,
      status: status,
      locationLabel: Access.text(location, max: 100),
      lastServicedAt: old?.lastServicedAt,
    );

    final result = id == null
        ? await SocietyEquipment.db.insertRow(s, row)
        : await SocietyEquipment.db.updateRow(s, row);
    await s.messages.postMessage('equipment-${p.societyId}', result);
    return result;
  }

  Stream<SocietyEquipment> watch(Session s) async* {
    final p = await Access.profile(s);
    yield* s.messages.createStream<SocietyEquipment>(
      'equipment-${p.societyId}',
    );
  }

  Future<MaintenanceIssue> report(
    Session s,
    int equipmentId,
    String title,
    String description,
    String severity,
  ) async {
    final p = await Access.profile(s);
    final e = await SocietyEquipment.db.findById(s, equipmentId);
    if (e == null || e.societyId != p.societyId) {
      throw GymException(message: 'Equipment not found.');
    }
    if (!['low', 'medium', 'high'].contains(severity)) {
      throw GymException(message: 'Invalid severity.');
    }

    final issue = await MaintenanceIssue.db.insertRow(
      s,
      MaintenanceIssue(
        societyId: p.societyId,
        societyEquipmentId: equipmentId,
        reportedBy: p.id!,
        title: Access.text(title, max: 100),
        description: Access.text(description),
        severity: severity,
        status: 'open',
        createdAt: DateTime.now().toUtc(),
      ),
    );
    await Notifications.toAdmins(
      s,
      p.societyId,
      'maintenance',
      'New issue: ${e.label}',
      '${issue.title} (${issue.severity} severity) reported by ${p.displayName}.',
      link: '/equipment',
      exceptUserId: p.id,
    );
    // Wake connected clients so the maintenance queue refreshes live.
    await s.messages.postMessage('equipment-${p.societyId}', e);
    return issue;
  }

  Future<List<MaintenanceIssue>> issues(Session s) async {
    final p = await Access.profile(s);
    return MaintenanceIssue.db.find(
      s,
      where: (t) => t.societyId.equals(p.societyId),
      orderBy: (t) => t.createdAt.desc(),
    );
  }

  Future<MaintenanceIssue> updateIssue(Session s, int id, String status) async {
    final p = await Access.profile(s, admin: true);
    final issue = await MaintenanceIssue.db.findById(s, id);
    if (issue == null || issue.societyId != p.societyId) {
      throw GymException(message: 'Issue not found.');
    }

    if (!['open', 'in progress', 'resolved'].contains(status)) {
      throw GymException(message: 'Invalid status.');
    }

    issue
      ..status = status
      ..resolvedAt = status == 'resolved' ? DateTime.now().toUtc() : null;
    await MaintenanceIssue.db.updateRow(s, issue);

    final e = (await SocietyEquipment.db.findById(
      s,
      issue.societyEquipmentId,
    ))!;

    final unresolved = await MaintenanceIssue.db.count(
      s,
      where: (t) =>
          t.societyEquipmentId.equals(e.id!) & t.status.notEquals('resolved'),
    );

    e.status = unresolved == 0 ? 'available' : 'maintenance';
    if (unresolved == 0) e.lastServicedAt = DateTime.now().toUtc();
    await SocietyEquipment.db.updateRow(s, e);
    if (issue.reportedBy != p.id) {
      await Notifications.send(
        s,
        issue.reportedBy,
        'maintenance',
        status == 'resolved'
            ? '${e.label} is fixed'
            : '${e.label}: issue ${status == 'in progress' ? 'in progress' : 'reopened'}',
        status == 'resolved'
            ? 'Your report "${issue.title}" was resolved${unresolved == 0 ? ' and the equipment is available again' : ''}.'
            : 'An admin updated your report "${issue.title}".',
        link: '/equipment',
      );
    }
    await s.messages.postMessage('equipment-${p.societyId}', e);
    return issue;
  }
}
