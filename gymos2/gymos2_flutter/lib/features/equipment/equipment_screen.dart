import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymos2_client/gymos2_client.dart';
import '../../client.dart';
import '../../app/theme.dart';
import '../../core/providers.dart';
import '../../core/widgets.dart';

class EquipmentScreen extends ConsumerWidget {
  const EquipmentScreen({super.key});
  Future<void> editEquipment(
    BuildContext context,
    WidgetRef ref, [
    SocietyEquipment? equipment,
  ]) async {
    final saved = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => _EquipmentDialog(equipment: equipment),
    );
    if (saved == true && context.mounted) {
      ref.invalidate(equipmentProvider);
      ref.invalidate(dashboardProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            equipment == null
                ? 'Equipment added to your gym.'
                : 'Equipment updated.',
          ),
        ),
      );
    }
  }

  Future<void> report(BuildContext c, WidgetRef ref, SocietyEquipment e) async {
    final title = TextEditingController(),
        description = TextEditingController();
    String severity = 'medium';
    final send = await showDialog<bool>(
      context: c,
      builder: (c) => StatefulBuilder(
        builder: (c, set) => AlertDialog(
          title: Text('Report ${e.label}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: title,
                  decoration: const InputDecoration(labelText: 'Issue title'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: description,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'What did you notice?',
                  ),
                ),
                DropdownButton<String>(
                  value: severity,
                  items: ['low', 'medium', 'high']
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (s) => set(() => severity = s!),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(c, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(c, true),
              child: const Text('Report issue'),
            ),
          ],
        ),
      ),
    );
    if (send == true && c.mounted) {
      final issue = await guarded(
        c,
        () => client.equipment.report(
          e.id!,
          title.text,
          description.text,
          severity,
        ),
      );
      if (issue != null) {
        ref.invalidate(issuesProvider);
        if (c.mounted) {
          ScaffoldMessenger.of(c).showSnackBar(
            const SnackBar(
              content: Text('Issue reported to your gym administrator.'),
            ),
          );
        }
      }
    }
    title.dispose();
    description.dispose();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final admin = ref.watch(profileProvider).value?.role == 'admin';
    return PageBody(
      children: [
        const PageTitle(
          'YOUR SHARED SPACE',
          'A gym that works for everyone.',
          'See what’s available and help keep your equipment in good shape.',
        ),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            if (admin)
              FilledButton.icon(
                onPressed: () => editEquipment(context, ref),
                icon: const Icon(Icons.add),
                label: const Text('Add equipment'),
              ),
            const StatusPill(
              'LIVE UPDATES',
              color: GymTheme.mint,
              dot: true,
            ),
          ],
        ),
        const SizedBox(height: 20),
        AsyncPanel(
          value: ref.watch(equipmentProvider),
          retry: () => ref.invalidate(equipmentProvider),
          builder: (list) => list.isEmpty
              ? const EmptyCard(
                  icon: Icons.fitness_center,
                  title: 'No equipment added yet',
                  message: 'Your society administrator can add gym equipment.',
                )
              : AdaptiveGrid(
                  minTileWidth: 340,
                  children: [
                    for (final e in list)
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Panel(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  IconBadge(
                                    Icons.fitness_center_rounded,
                                    color: GymTheme.status(e.status),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e.label,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                        ),
                                        Text(
                                          '${e.locationLabel} • ${e.quantity} units${e.lastServicedAt == null ? '' : ' • serviced ${relativeDay(e.lastServicedAt!).toLowerCase()}'}',
                                          style: const TextStyle(
                                            color: GymTheme.muted,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  StatusPill(
                                    e.status.toUpperCase(),
                                    color: GymTheme.status(e.status),
                                    dot: true,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 12,
                                children: [
                                  TextButton.icon(
                                    onPressed: () => report(context, ref, e),
                                    icon: const Icon(Icons.flag_outlined),
                                    label: const Text('Report issue'),
                                  ),
                                  if (admin)
                                    TextButton.icon(
                                      onPressed: () =>
                                          editEquipment(context, ref, e),
                                      icon: const Icon(Icons.edit_outlined),
                                      label: const Text('Edit equipment'),
                                    ),
                                  if (admin)
                                    PopupMenuButton<String>(
                                      tooltip: 'Change equipment status',
                                      onSelected: (status) async {
                                        await guarded(
                                          context,
                                          () => client.equipment.save(
                                            e.id,
                                            e.equipmentId,
                                            e.label,
                                            e.quantity,
                                            status,
                                            e.locationLabel,
                                          ),
                                        );
                                        ref.invalidate(equipmentProvider);
                                        ref.invalidate(dashboardProvider);
                                      },
                                      itemBuilder: (c) =>
                                          [
                                                'available',
                                                'maintenance',
                                                'unavailable',
                                              ]
                                              .map(
                                                (s) => PopupMenuItem(
                                                  value: s,
                                                  child: Text(s),
                                                ),
                                              )
                                              .toList(),
                                      child: const Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Text(
                                          'Change status',
                                          style: TextStyle(
                                            color: GymTheme.accent,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
        ),
        const SectionTitle(
          'Maintenance board',
          icon: Icons.build_circle_outlined,
        ),
        AsyncPanel(
          value: ref.watch(issuesProvider),
          retry: () => ref.invalidate(issuesProvider),
          builder: (issues) => issues.isEmpty
              ? const EmptyCard(
                  icon: Icons.check_circle_outline,
                  title: 'Nothing to report',
                  message:
                      'Equipment issues from your community will appear here.',
                )
              : Column(
                  children: [
                    for (final i in issues)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Panel(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      i.title,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium,
                                    ),
                                  ),
                                  StatusPill(
                                    i.status.toUpperCase(),
                                    color: GymTheme.status(
                                      i.status == 'in progress'
                                          ? 'in progress'
                                          : i.status == 'resolved'
                                          ? 'resolved'
                                          : 'open',
                                    ),
                                    dot: true,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                i.description,
                                style: const TextStyle(color: GymTheme.muted),
                              ),
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 10,
                                runSpacing: 6,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  StatusPill(
                                    '${i.severity.toUpperCase()} SEVERITY',
                                    color: switch (i.severity) {
                                      'high' => GymTheme.coral,
                                      'medium' => GymTheme.orange,
                                      _ => GymTheme.sky,
                                    },
                                  ),
                                  Text(
                                    'Reported ${relativeDay(i.createdAt).toLowerCase()}${i.resolvedAt == null ? '' : ' · resolved ${relativeDay(i.resolvedAt!).toLowerCase()}'}',
                                    style: const TextStyle(
                                      color: GymTheme.subtle,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              if (admin)
                                Wrap(
                                  spacing: 8,
                                  children: [
                                    for (final status in [
                                      'in progress',
                                      'resolved',
                                    ])
                                      TextButton(
                                        onPressed: i.status == status
                                            ? null
                                            : () async {
                                                await guarded(
                                                  context,
                                                  () => client.equipment
                                                      .updateIssue(
                                                        i.id!,
                                                        status,
                                                      ),
                                                );
                                                ref.invalidate(issuesProvider);
                                                ref.invalidate(
                                                  equipmentProvider,
                                                );
                                                ref.invalidate(
                                                  dashboardProvider,
                                                );
                                              },
                                        child: Text('Mark $status'),
                                      ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
        ),
      ],
    );
  }
}

class _EquipmentDialog extends StatefulWidget {
  final SocietyEquipment? equipment;
  const _EquipmentDialog({this.equipment});

  @override
  State<_EquipmentDialog> createState() => _EquipmentDialogState();
}

class _EquipmentDialogState extends State<_EquipmentDialog> {
  final form = GlobalKey<FormState>();
  late final TextEditingController label;
  late final TextEditingController quantity;
  late final TextEditingController location;
  late Future<List<EquipmentCatalog>> catalog;
  int? selectedId;
  late String status;
  bool saving = false;
  String? failure;

  @override
  void initState() {
    super.initState();
    final e = widget.equipment;
    label = TextEditingController(text: e?.label ?? '');
    quantity = TextEditingController(text: '${e?.quantity ?? 1}');
    location = TextEditingController(text: e?.locationLabel ?? '');
    selectedId = e?.equipmentId;
    status = e?.status ?? 'available';
    catalog = client.equipment.catalog();
  }

  @override
  void dispose() {
    label.dispose();
    quantity.dispose();
    location.dispose();
    super.dispose();
  }

  Future<void> save(int catalogId) async {
    if (!form.currentState!.validate()) return;
    setState(() {
      saving = true;
      failure = null;
    });
    try {
      await client.equipment.save(
        widget.equipment?.id,
        catalogId,
        label.text.trim(),
        int.parse(quantity.text.trim()),
        status,
        location.text.trim(),
      );
      if (mounted) Navigator.pop(context, true);
    } catch (error) {
      if (mounted) {
        setState(() {
          saving = false;
          failure = errorText(error);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: !saving,
    child: FutureBuilder<List<EquipmentCatalog>>(
      future: catalog,
      builder: (context, snapshot) {
        final options =
            snapshot.data?.where((e) => e.id != null).toList() ?? [];
        final chosen = options.any((e) => e.id == selectedId)
            ? selectedId
            : options.firstOrNull?.id;
        return AlertDialog(
          title: Text(
            widget.equipment == null
                ? 'Add gym equipment'
                : 'Edit gym equipment',
          ),
          content: SizedBox(
            width: 440,
            child: SingleChildScrollView(
              child: snapshot.connectionState != ConnectionState.done
                  ? const Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : snapshot.hasError
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(errorText(snapshot.error!)),
                        const SizedBox(height: 16),
                        OutlinedButton.icon(
                          onPressed: () => setState(() {
                            catalog = client.equipment.catalog();
                          }),
                          icon: const Icon(Icons.refresh),
                          label: const Text('Retry equipment types'),
                        ),
                      ],
                    )
                  : options.isEmpty
                  ? const Text(
                      'No equipment types are available yet. Please try again later.',
                    )
                  : Form(
                      key: form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          DropdownButtonFormField<int>(
                            initialValue: chosen,
                            isExpanded: true,
                            decoration: const InputDecoration(
                              labelText: 'Equipment type',
                            ),
                            items: [
                              for (final e in options)
                                DropdownMenuItem(
                                  value: e.id,
                                  child: Text(e.name),
                                ),
                            ],
                            onChanged: saving
                                ? null
                                : (value) => setState(() => selectedId = value),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: label,
                            enabled: !saving,
                            maxLength: 80,
                            decoration: const InputDecoration(
                              labelText: 'Equipment name',
                              hintText: 'For example, Dumbbell rack A',
                            ),
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                ? 'Enter an equipment name.'
                                : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: quantity,
                            enabled: !saving,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Quantity',
                              helperText: 'Number of units, from 0 to 100',
                            ),
                            validator: (value) {
                              final n = int.tryParse(value?.trim() ?? '');
                              return n == null || n < 0 || n > 100
                                  ? 'Enter a whole number from 0 to 100.'
                                  : null;
                            },
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            initialValue: status,
                            decoration: const InputDecoration(
                              labelText: 'Status',
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'available',
                                child: Text('Available'),
                              ),
                              DropdownMenuItem(
                                value: 'maintenance',
                                child: Text('Under maintenance'),
                              ),
                              DropdownMenuItem(
                                value: 'unavailable',
                                child: Text('Unavailable'),
                              ),
                            ],
                            onChanged: saving
                                ? null
                                : (value) => setState(() => status = value!),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: location,
                            enabled: !saving,
                            maxLength: 100,
                            decoration: const InputDecoration(
                              labelText: 'Location',
                              hintText: 'For example, First floor gym',
                            ),
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                ? 'Enter the equipment location.'
                                : null,
                          ),
                          if (failure != null) ...[
                            const SizedBox(height: 12),
                            Text(
                              failure!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: saving ? null : () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed:
                  saving ||
                      chosen == null ||
                      snapshot.connectionState != ConnectionState.done ||
                      snapshot.hasError
                  ? null
                  : () => save(chosen),
              child: Text(saving ? 'Saving…' : 'Save equipment'),
            ),
          ],
        );
      },
    ),
  );
}
