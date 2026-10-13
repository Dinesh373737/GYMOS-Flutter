/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:gymos2_server/src/generated/agent_conversation.dart'
    as _i6mq3o3m;
import 'package:gymos2_server/src/generated/agent_message.dart' as _innjtlir;
import 'package:gymos2_server/src/generated/equipment_catalog.dart'
    as _ic8y81dj;
import 'package:gymos2_server/src/generated/exercise.dart' as _i5n6a3j6;
import 'package:gymos2_server/src/generated/exercise_point.dart' as _is1aniw9;
import 'package:gymos2_server/src/generated/form_analysis.dart' as _ig65cdz4;
import 'package:gymos2_server/src/generated/form_metric.dart' as _itbundlj;
import 'package:gymos2_server/src/generated/maintenance_issue.dart'
    as _iomqde0w;
import 'package:gymos2_server/src/generated/member_summary.dart' as _iavy0mxp;
import 'package:gymos2_server/src/generated/notification.dart' as _imobafje;
import 'package:gymos2_server/src/generated/readiness_point.dart' as _ipwgcu1g;
import 'package:gymos2_server/src/generated/society_equipment.dart'
    as _iutnld8j;
import 'package:gymos2_server/src/generated/training_readiness.dart'
    as _i1jesnnt;
import 'package:gymos2_server/src/generated/user_profile.dart' as _i8zxo9ts;
import 'package:gymos2_server/src/generated/workout_plan.dart' as _io1vm9xv;
import 'package:gymos2_server/src/generated/workout_session.dart' as _ir65ydpz;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'admin_stats.dart' as _iqygks5s;
import 'agent_action.dart' as _i5uera5m;
import 'agent_conversation.dart' as _ixlrnuhd;
import 'agent_message.dart' as _ips3h0rm;
import 'agent_reply.dart' as _igee92io;
import 'community_event.dart' as _inypuiwd;
import 'dashboard_data.dart' as _irt0lj0o;
import 'discover_data.dart' as _i79facbx;
import 'equipment_catalog.dart' as _i4uc3nar;
import 'event_participant.dart' as _i5ye7mcz;
import 'exercise.dart' as _ij3o2h1q;
import 'exercise_alternative.dart' as _iu06qsr2;
import 'exercise_equipment.dart' as _i64c2fru;
import 'exercise_muscle.dart' as _iqbnnuq3;
import 'exercise_point.dart' as _i92yp22h;
import 'external_event_cache.dart' as _imhmmzbr;
import 'form_analysis.dart' as _i1g08zve;
import 'form_metric.dart' as _i85mqlmj;
import 'form_result.dart' as _i4yrss3y;
import 'gym_exception.dart' as _inpsb4xt;
import 'maintenance_issue.dart' as _i4who45y;
import 'member_summary.dart' as _im0mslp7;
import 'muscle_group.dart' as _io46uma7;
import 'notification.dart' as _irt10kca;
import 'plan_detail.dart' as _ijosjbbk;
import 'readiness_point.dart' as _ibymmiv6;
import 'session_detail.dart' as _izqv72qt;
import 'society.dart' as _imb18de8;
import 'society_equipment.dart' as _isihw7hu;
import 'society_membership.dart' as _iolaa93q;
import 'training_readiness.dart' as _izoaoiwz;
import 'user_profile.dart' as _ir2mn8w1;
import 'workout_plan.dart' as _ibmdzv6r;
import 'workout_plan_item.dart' as _ikhy8p9s;
import 'workout_session.dart' as _ic5tnsvc;
import 'workout_set.dart' as _ia8z1hbl;
export 'admin_stats.dart';
export 'agent_action.dart';
export 'agent_conversation.dart';
export 'agent_message.dart';
export 'agent_reply.dart';
export 'community_event.dart';
export 'dashboard_data.dart';
export 'discover_data.dart';
export 'equipment_catalog.dart';
export 'event_participant.dart';
export 'exercise.dart';
export 'exercise_alternative.dart';
export 'exercise_equipment.dart';
export 'exercise_muscle.dart';
export 'exercise_point.dart';
export 'external_event_cache.dart';
export 'form_analysis.dart';
export 'form_metric.dart';
export 'form_result.dart';
export 'gym_exception.dart';
export 'maintenance_issue.dart';
export 'member_summary.dart';
export 'muscle_group.dart';
export 'notification.dart';
export 'plan_detail.dart';
export 'readiness_point.dart';
export 'session_detail.dart';
export 'society.dart';
export 'society_equipment.dart';
export 'society_membership.dart';
export 'training_readiness.dart';
export 'user_profile.dart';
export 'workout_plan.dart';
export 'workout_plan_item.dart';
export 'workout_session.dart';
export 'workout_set.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'agent_action',
      dartName: 'AgentAction',
      schema: 'public',
      module: 'gymos2',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'conversationId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'toolName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'requestSummary',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'resultSummary',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'durationMs',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'agent_action_fk_0',
          columns: ['conversationId'],
          referenceTable: 'agent_conversation',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'agent_action_fk_1',
          columns: ['userId'],
          referenceTable: 'user_profile',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'agent_action_lookup',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'conversationId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'agent_conversation',
      dartName: 'AgentConversation',
      schema: 'public',
      module: 'gymos2',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'agent_conversation_fk_0',
          columns: ['userId'],
          referenceTable: 'user_profile',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'agent_conversation_lookup',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'agent_message',
      dartName: 'AgentMessage',
      schema: 'public',
      module: 'gymos2',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'conversationId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'role',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'content',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'agent_message_fk_0',
          columns: ['conversationId'],
          referenceTable: 'agent_conversation',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'agent_message_lookup',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'conversationId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'community_event',
      dartName: 'CommunityEvent',
      schema: 'public',
      module: 'gymos2',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'societyId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'organizerUserId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'category',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'startsAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'endsAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'latitude',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'longitude',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'venueLabel',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'capacity',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'isDemo',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'community_event_fk_0',
          columns: ['societyId'],
          referenceTable: 'society',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'community_event_fk_1',
          columns: ['organizerUserId'],
          referenceTable: 'user_profile',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'community_event_lookup',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'societyId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'equipment_catalog',
      dartName: 'EquipmentCatalog',
      schema: 'public',
      module: 'gymos2',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'category',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'equipment_catalog_unique',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'name',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'event_participant',
      dartName: 'EventParticipant',
      schema: 'public',
      module: 'gymos2',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'eventId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'joinedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'event_participant_fk_0',
          columns: ['eventId'],
          referenceTable: 'community_event',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'event_participant_fk_1',
          columns: ['userId'],
          referenceTable: 'user_profile',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'event_participant_unique',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'eventId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'exercise',
      dartName: 'Exercise',
      schema: 'public',
      module: 'gymos2',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'slug',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'instructions',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'difficulty',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'movementPattern',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'exerciseType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'defaultDurationMin',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'isActive',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'exercise_unique',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'slug',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'exercise_lookup',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'name',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'exercise_alternative',
      dartName: 'ExerciseAlternative',
      schema: 'public',
      module: 'gymos2',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'sourceExerciseId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'alternativeExerciseId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'similarityScore',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'notes',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'exercise_alternative_fk_0',
          columns: ['sourceExerciseId'],
          referenceTable: 'exercise',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'exercise_alternative_fk_1',
          columns: ['alternativeExerciseId'],
          referenceTable: 'exercise',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'exercise_alternative_unique',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'sourceExerciseId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'alternativeExerciseId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'exercise_equipment',
      dartName: 'ExerciseEquipment',
      schema: 'public',
      module: 'gymos2',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'exerciseId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'equipmentId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'required',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'exercise_equipment_fk_0',
          columns: ['exerciseId'],
          referenceTable: 'exercise',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'exercise_equipment_fk_1',
          columns: ['equipmentId'],
          referenceTable: 'equipment_catalog',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'exercise_equipment_unique',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'exerciseId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'equipmentId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'exercise_muscle',
      dartName: 'ExerciseMuscle',
      schema: 'public',
      module: 'gymos2',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'exerciseId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'muscleGroupId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'contribution',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'exercise_muscle_fk_0',
          columns: ['exerciseId'],
          referenceTable: 'exercise',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'exercise_muscle_fk_1',
          columns: ['muscleGroupId'],
          referenceTable: 'muscle_group',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'exercise_muscle_unique',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'exerciseId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'muscleGroupId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'external_event_cache',
      dartName: 'ExternalEventCache',
      schema: 'public',
      module: 'gymos2',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'provider',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'providerEventId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'queryKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'category',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'startsAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'endsAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'latitude',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _isp.ColumnDefinition(
          name: 'longitude',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _isp.ColumnDefinition(
          name: 'venueLabel',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'organizerName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'imageUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'sourceUrl',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'rawHash',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'fetchedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'expiresAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'external_event_cache_lookup',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'provider',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'external_event_cache_query',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'queryKey',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'startsAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'external_event_cache_unique',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'provider',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'queryKey',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'providerEventId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'form_analysis',
      dartName: 'FormAnalysis',
      schema: 'public',
      module: 'gymos2',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'exerciseId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'checkpoint',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'capturedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'analysisType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'resultBand',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'confidence',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'summary',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'retainedImagePath',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'form_analysis_fk_0',
          columns: ['userId'],
          referenceTable: 'user_profile',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'form_analysis_fk_1',
          columns: ['exerciseId'],
          referenceTable: 'exercise',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'form_analysis_lookup',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'form_metric',
      dartName: 'FormMetric',
      schema: 'public',
      module: 'gymos2',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'formAnalysisId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'metricName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'measuredValue',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'unit',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'targetRangeText',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'confidence',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'cue',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'form_metric_fk_0',
          columns: ['formAnalysisId'],
          referenceTable: 'form_analysis',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'form_metric_lookup',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'formAnalysisId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'maintenance_issue',
      dartName: 'MaintenanceIssue',
      schema: 'public',
      module: 'gymos2',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'societyId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'societyEquipmentId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'reportedBy',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'severity',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'photoPath',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'resolvedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'maintenance_issue_fk_0',
          columns: ['societyId'],
          referenceTable: 'society',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'maintenance_issue_fk_1',
          columns: ['societyEquipmentId'],
          referenceTable: 'society_equipment',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'maintenance_issue_fk_2',
          columns: ['reportedBy'],
          referenceTable: 'user_profile',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'maintenance_issue_lookup',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'societyId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'muscle_group',
      dartName: 'MuscleGroup',
      schema: 'public',
      module: 'gymos2',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'bodyArea',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'muscle_group_unique',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'name',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'notification',
      dartName: 'Notification',
      schema: 'public',
      module: 'gymos2',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'type',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'body',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'link',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'readAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'notification_fk_0',
          columns: ['userId'],
          referenceTable: 'user_profile',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'notification_lookup',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'notification_recent',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'society',
      dartName: 'Society',
      schema: 'public',
      module: 'gymos2',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'addressLabel',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'inviteCode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdBy',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'isActive',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'society_unique',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'inviteCode',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'society_lookup',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'name',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'society_equipment',
      dartName: 'SocietyEquipment',
      schema: 'public',
      module: 'gymos2',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'societyId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'equipmentId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'label',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'quantity',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'locationLabel',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'lastServicedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'society_equipment_fk_0',
          columns: ['societyId'],
          referenceTable: 'society',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'society_equipment_fk_1',
          columns: ['equipmentId'],
          referenceTable: 'equipment_catalog',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'society_equipment_lookup',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'societyId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'society_membership',
      dartName: 'SocietyMembership',
      schema: 'public',
      module: 'gymos2',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'societyId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'role',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'joinedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'isActive',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'society_membership_fk_0',
          columns: ['societyId'],
          referenceTable: 'society',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'society_membership_fk_1',
          columns: ['userId'],
          referenceTable: 'user_profile',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'society_membership_unique',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'societyId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'training_readiness',
      dartName: 'TrainingReadiness',
      schema: 'public',
      module: 'gymos2',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'muscleGroupId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'muscleName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'trainingLoadScore',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'readinessBand',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'lastTrainedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'computedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'explanation',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'training_readiness_fk_0',
          columns: ['userId'],
          referenceTable: 'user_profile',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'training_readiness_fk_1',
          columns: ['muscleGroupId'],
          referenceTable: 'muscle_group',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'training_readiness_unique',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'muscleGroupId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'user_profile',
      dartName: 'UserProfile',
      schema: 'public',
      module: 'gymos2',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'displayName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'role',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'societyId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'experienceLevel',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'primaryGoal',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'preferredWorkoutDuration',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'onboardingComplete',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'user_profile_fk_0',
          columns: ['societyId'],
          referenceTable: 'society',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'user_profile_unique',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'workout_plan',
      dartName: 'WorkoutPlan',
      schema: 'public',
      module: 'gymos2',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdByType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'target',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'plannedDurationMin',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'workout_plan_fk_0',
          columns: ['userId'],
          referenceTable: 'user_profile',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'workout_plan_lookup',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'workout_plan_item',
      dartName: 'WorkoutPlanItem',
      schema: 'public',
      module: 'gymos2',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'planId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'exerciseId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'orderIndex',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'targetSets',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'targetRepsText',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'suggestedWeight',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _isp.ColumnDefinition(
          name: 'restSeconds',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'rationale',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'workout_plan_item_fk_0',
          columns: ['planId'],
          referenceTable: 'workout_plan',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'workout_plan_item_fk_1',
          columns: ['exerciseId'],
          referenceTable: 'exercise',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'workout_plan_item_lookup',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'planId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'workout_session',
      dartName: 'WorkoutSession',
      schema: 'public',
      module: 'gymos2',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'planId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'startedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'endedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'durationMin',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'notes',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'perceivedEffort',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'workout_session_fk_0',
          columns: ['userId'],
          referenceTable: 'user_profile',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'workout_session_fk_1',
          columns: ['planId'],
          referenceTable: 'workout_plan',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'workout_session_lookup',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'workout_set',
      dartName: 'WorkoutSet',
      schema: 'public',
      module: 'gymos2',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'sessionId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'exerciseId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'setNumber',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'reps',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'weightKg',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _isp.ColumnDefinition(
          name: 'durationSec',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'rpe',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _isp.ColumnDefinition(
          name: 'completedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'workout_set_fk_0',
          columns: ['sessionId'],
          referenceTable: 'workout_session',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'workout_set_fk_1',
          columns: ['exerciseId'],
          referenceTable: 'exercise',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'workout_set_lookup',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'sessionId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'workout_set_identity',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'sessionId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'exerciseId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'setNumber',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _iqygks5s.AdminStats) {
      return _iqygks5s.AdminStats.fromJson(data) as T;
    }
    if (t == _i5uera5m.AgentAction) {
      return _i5uera5m.AgentAction.fromJson(data) as T;
    }
    if (t == _ixlrnuhd.AgentConversation) {
      return _ixlrnuhd.AgentConversation.fromJson(data) as T;
    }
    if (t == _ips3h0rm.AgentMessage) {
      return _ips3h0rm.AgentMessage.fromJson(data) as T;
    }
    if (t == _igee92io.AgentReply) {
      return _igee92io.AgentReply.fromJson(data) as T;
    }
    if (t == _inypuiwd.CommunityEvent) {
      return _inypuiwd.CommunityEvent.fromJson(data) as T;
    }
    if (t == _irt0lj0o.DashboardData) {
      return _irt0lj0o.DashboardData.fromJson(data) as T;
    }
    if (t == _i79facbx.DiscoverData) {
      return _i79facbx.DiscoverData.fromJson(data) as T;
    }
    if (t == _i4uc3nar.EquipmentCatalog) {
      return _i4uc3nar.EquipmentCatalog.fromJson(data) as T;
    }
    if (t == _i5ye7mcz.EventParticipant) {
      return _i5ye7mcz.EventParticipant.fromJson(data) as T;
    }
    if (t == _ij3o2h1q.Exercise) {
      return _ij3o2h1q.Exercise.fromJson(data) as T;
    }
    if (t == _iu06qsr2.ExerciseAlternative) {
      return _iu06qsr2.ExerciseAlternative.fromJson(data) as T;
    }
    if (t == _i64c2fru.ExerciseEquipment) {
      return _i64c2fru.ExerciseEquipment.fromJson(data) as T;
    }
    if (t == _iqbnnuq3.ExerciseMuscle) {
      return _iqbnnuq3.ExerciseMuscle.fromJson(data) as T;
    }
    if (t == _i92yp22h.ExercisePoint) {
      return _i92yp22h.ExercisePoint.fromJson(data) as T;
    }
    if (t == _imhmmzbr.ExternalEventCache) {
      return _imhmmzbr.ExternalEventCache.fromJson(data) as T;
    }
    if (t == _i1g08zve.FormAnalysis) {
      return _i1g08zve.FormAnalysis.fromJson(data) as T;
    }
    if (t == _i85mqlmj.FormMetric) {
      return _i85mqlmj.FormMetric.fromJson(data) as T;
    }
    if (t == _i4yrss3y.FormResult) {
      return _i4yrss3y.FormResult.fromJson(data) as T;
    }
    if (t == _inpsb4xt.GymException) {
      return _inpsb4xt.GymException.fromJson(data) as T;
    }
    if (t == _i4who45y.MaintenanceIssue) {
      return _i4who45y.MaintenanceIssue.fromJson(data) as T;
    }
    if (t == _im0mslp7.MemberSummary) {
      return _im0mslp7.MemberSummary.fromJson(data) as T;
    }
    if (t == _io46uma7.MuscleGroup) {
      return _io46uma7.MuscleGroup.fromJson(data) as T;
    }
    if (t == _irt10kca.Notification) {
      return _irt10kca.Notification.fromJson(data) as T;
    }
    if (t == _ijosjbbk.PlanDetail) {
      return _ijosjbbk.PlanDetail.fromJson(data) as T;
    }
    if (t == _ibymmiv6.ReadinessPoint) {
      return _ibymmiv6.ReadinessPoint.fromJson(data) as T;
    }
    if (t == _izqv72qt.SessionDetail) {
      return _izqv72qt.SessionDetail.fromJson(data) as T;
    }
    if (t == _imb18de8.Society) {
      return _imb18de8.Society.fromJson(data) as T;
    }
    if (t == _isihw7hu.SocietyEquipment) {
      return _isihw7hu.SocietyEquipment.fromJson(data) as T;
    }
    if (t == _iolaa93q.SocietyMembership) {
      return _iolaa93q.SocietyMembership.fromJson(data) as T;
    }
    if (t == _izoaoiwz.TrainingReadiness) {
      return _izoaoiwz.TrainingReadiness.fromJson(data) as T;
    }
    if (t == _ir2mn8w1.UserProfile) {
      return _ir2mn8w1.UserProfile.fromJson(data) as T;
    }
    if (t == _ibmdzv6r.WorkoutPlan) {
      return _ibmdzv6r.WorkoutPlan.fromJson(data) as T;
    }
    if (t == _ikhy8p9s.WorkoutPlanItem) {
      return _ikhy8p9s.WorkoutPlanItem.fromJson(data) as T;
    }
    if (t == _ic5tnsvc.WorkoutSession) {
      return _ic5tnsvc.WorkoutSession.fromJson(data) as T;
    }
    if (t == _ia8z1hbl.WorkoutSet) {
      return _ia8z1hbl.WorkoutSet.fromJson(data) as T;
    }
    if (t == _is.getType<_iqygks5s.AdminStats?>()) {
      return (data != null ? _iqygks5s.AdminStats.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i5uera5m.AgentAction?>()) {
      return (data != null ? _i5uera5m.AgentAction.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ixlrnuhd.AgentConversation?>()) {
      return (data != null ? _ixlrnuhd.AgentConversation.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ips3h0rm.AgentMessage?>()) {
      return (data != null ? _ips3h0rm.AgentMessage.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_igee92io.AgentReply?>()) {
      return (data != null ? _igee92io.AgentReply.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_inypuiwd.CommunityEvent?>()) {
      return (data != null ? _inypuiwd.CommunityEvent.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_irt0lj0o.DashboardData?>()) {
      return (data != null ? _irt0lj0o.DashboardData.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i79facbx.DiscoverData?>()) {
      return (data != null ? _i79facbx.DiscoverData.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i4uc3nar.EquipmentCatalog?>()) {
      return (data != null ? _i4uc3nar.EquipmentCatalog.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i5ye7mcz.EventParticipant?>()) {
      return (data != null ? _i5ye7mcz.EventParticipant.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ij3o2h1q.Exercise?>()) {
      return (data != null ? _ij3o2h1q.Exercise.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iu06qsr2.ExerciseAlternative?>()) {
      return (data != null
              ? _iu06qsr2.ExerciseAlternative.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i64c2fru.ExerciseEquipment?>()) {
      return (data != null ? _i64c2fru.ExerciseEquipment.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iqbnnuq3.ExerciseMuscle?>()) {
      return (data != null ? _iqbnnuq3.ExerciseMuscle.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i92yp22h.ExercisePoint?>()) {
      return (data != null ? _i92yp22h.ExercisePoint.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_imhmmzbr.ExternalEventCache?>()) {
      return (data != null ? _imhmmzbr.ExternalEventCache.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i1g08zve.FormAnalysis?>()) {
      return (data != null ? _i1g08zve.FormAnalysis.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i85mqlmj.FormMetric?>()) {
      return (data != null ? _i85mqlmj.FormMetric.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i4yrss3y.FormResult?>()) {
      return (data != null ? _i4yrss3y.FormResult.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_inpsb4xt.GymException?>()) {
      return (data != null ? _inpsb4xt.GymException.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i4who45y.MaintenanceIssue?>()) {
      return (data != null ? _i4who45y.MaintenanceIssue.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_im0mslp7.MemberSummary?>()) {
      return (data != null ? _im0mslp7.MemberSummary.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_io46uma7.MuscleGroup?>()) {
      return (data != null ? _io46uma7.MuscleGroup.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_irt10kca.Notification?>()) {
      return (data != null ? _irt10kca.Notification.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ijosjbbk.PlanDetail?>()) {
      return (data != null ? _ijosjbbk.PlanDetail.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ibymmiv6.ReadinessPoint?>()) {
      return (data != null ? _ibymmiv6.ReadinessPoint.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_izqv72qt.SessionDetail?>()) {
      return (data != null ? _izqv72qt.SessionDetail.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_imb18de8.Society?>()) {
      return (data != null ? _imb18de8.Society.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_isihw7hu.SocietyEquipment?>()) {
      return (data != null ? _isihw7hu.SocietyEquipment.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iolaa93q.SocietyMembership?>()) {
      return (data != null ? _iolaa93q.SocietyMembership.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_izoaoiwz.TrainingReadiness?>()) {
      return (data != null ? _izoaoiwz.TrainingReadiness.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ir2mn8w1.UserProfile?>()) {
      return (data != null ? _ir2mn8w1.UserProfile.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ibmdzv6r.WorkoutPlan?>()) {
      return (data != null ? _ibmdzv6r.WorkoutPlan.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ikhy8p9s.WorkoutPlanItem?>()) {
      return (data != null ? _ikhy8p9s.WorkoutPlanItem.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ic5tnsvc.WorkoutSession?>()) {
      return (data != null ? _ic5tnsvc.WorkoutSession.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ia8z1hbl.WorkoutSet?>()) {
      return (data != null ? _ia8z1hbl.WorkoutSet.fromJson(data) : null) as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i5uera5m.AgentAction>) {
      return (data as List)
              .map((e) => deserialize<_i5uera5m.AgentAction>(e))
              .toList()
          as T;
    }
    if (t == List<_isihw7hu.SocietyEquipment>) {
      return (data as List)
              .map((e) => deserialize<_isihw7hu.SocietyEquipment>(e))
              .toList()
          as T;
    }
    if (t == List<_izoaoiwz.TrainingReadiness>) {
      return (data as List)
              .map((e) => deserialize<_izoaoiwz.TrainingReadiness>(e))
              .toList()
          as T;
    }
    if (t == List<_ic5tnsvc.WorkoutSession>) {
      return (data as List)
              .map((e) => deserialize<_ic5tnsvc.WorkoutSession>(e))
              .toList()
          as T;
    }
    if (t == List<_inypuiwd.CommunityEvent>) {
      return (data as List)
              .map((e) => deserialize<_inypuiwd.CommunityEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_imhmmzbr.ExternalEventCache>) {
      return (data as List)
              .map((e) => deserialize<_imhmmzbr.ExternalEventCache>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _is.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == Map<int, int>) {
      return Map.fromEntries(
            (data as List).map(
              (e) =>
                  MapEntry(deserialize<int>(e['k']), deserialize<int>(e['v'])),
            ),
          )
          as T;
    }
    if (t == _is.getType<Map<int, int>?>()) {
      return (data != null
              ? Map.fromEntries(
                  (data as List).map(
                    (e) => MapEntry(
                      deserialize<int>(e['k']),
                      deserialize<int>(e['v']),
                    ),
                  ),
                )
              : null)
          as T;
    }
    if (t == List<_i85mqlmj.FormMetric>) {
      return (data as List)
              .map((e) => deserialize<_i85mqlmj.FormMetric>(e))
              .toList()
          as T;
    }
    if (t == List<_ikhy8p9s.WorkoutPlanItem>) {
      return (data as List)
              .map((e) => deserialize<_ikhy8p9s.WorkoutPlanItem>(e))
              .toList()
          as T;
    }
    if (t == List<_ij3o2h1q.Exercise>) {
      return (data as List)
              .map((e) => deserialize<_ij3o2h1q.Exercise>(e))
              .toList()
          as T;
    }
    if (t == List<_ia8z1hbl.WorkoutSet>) {
      return (data as List)
              .map((e) => deserialize<_ia8z1hbl.WorkoutSet>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_ia8z1hbl.WorkoutSet>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ia8z1hbl.WorkoutSet>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iavy0mxp.MemberSummary>) {
      return (data as List)
              .map((e) => deserialize<_iavy0mxp.MemberSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i6mq3o3m.AgentConversation>) {
      return (data as List)
              .map((e) => deserialize<_i6mq3o3m.AgentConversation>(e))
              .toList()
          as T;
    }
    if (t == List<_innjtlir.AgentMessage>) {
      return (data as List)
              .map((e) => deserialize<_innjtlir.AgentMessage>(e))
              .toList()
          as T;
    }
    if (t == List<_iutnld8j.SocietyEquipment>) {
      return (data as List)
              .map((e) => deserialize<_iutnld8j.SocietyEquipment>(e))
              .toList()
          as T;
    }
    if (t == List<_ic8y81dj.EquipmentCatalog>) {
      return (data as List)
              .map((e) => deserialize<_ic8y81dj.EquipmentCatalog>(e))
              .toList()
          as T;
    }
    if (t == List<_iomqde0w.MaintenanceIssue>) {
      return (data as List)
              .map((e) => deserialize<_iomqde0w.MaintenanceIssue>(e))
              .toList()
          as T;
    }
    if (t == List<_i5n6a3j6.Exercise>) {
      return (data as List)
              .map((e) => deserialize<_i5n6a3j6.Exercise>(e))
              .toList()
          as T;
    }
    if (t == List<_itbundlj.FormMetric>) {
      return (data as List)
              .map((e) => deserialize<_itbundlj.FormMetric>(e))
              .toList()
          as T;
    }
    if (t == List<_ig65cdz4.FormAnalysis>) {
      return (data as List)
              .map((e) => deserialize<_ig65cdz4.FormAnalysis>(e))
              .toList()
          as T;
    }
    if (t == List<_imobafje.Notification>) {
      return (data as List)
              .map((e) => deserialize<_imobafje.Notification>(e))
              .toList()
          as T;
    }
    if (t == List<_i8zxo9ts.UserProfile>) {
      return (data as List)
              .map((e) => deserialize<_i8zxo9ts.UserProfile>(e))
              .toList()
          as T;
    }
    if (t == List<_io1vm9xv.WorkoutPlan>) {
      return (data as List)
              .map((e) => deserialize<_io1vm9xv.WorkoutPlan>(e))
              .toList()
          as T;
    }
    if (t == List<_ir65ydpz.WorkoutSession>) {
      return (data as List)
              .map((e) => deserialize<_ir65ydpz.WorkoutSession>(e))
              .toList()
          as T;
    }
    if (t == List<_i1jesnnt.TrainingReadiness>) {
      return (data as List)
              .map((e) => deserialize<_i1jesnnt.TrainingReadiness>(e))
              .toList()
          as T;
    }
    if (t == List<_is1aniw9.ExercisePoint>) {
      return (data as List)
              .map((e) => deserialize<_is1aniw9.ExercisePoint>(e))
              .toList()
          as T;
    }
    if (t == List<_ipwgcu1g.ReadinessPoint>) {
      return (data as List)
              .map((e) => deserialize<_ipwgcu1g.ReadinessPoint>(e))
              .toList()
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _iqygks5s.AdminStats => 'AdminStats',
      _i5uera5m.AgentAction => 'AgentAction',
      _ixlrnuhd.AgentConversation => 'AgentConversation',
      _ips3h0rm.AgentMessage => 'AgentMessage',
      _igee92io.AgentReply => 'AgentReply',
      _inypuiwd.CommunityEvent => 'CommunityEvent',
      _irt0lj0o.DashboardData => 'DashboardData',
      _i79facbx.DiscoverData => 'DiscoverData',
      _i4uc3nar.EquipmentCatalog => 'EquipmentCatalog',
      _i5ye7mcz.EventParticipant => 'EventParticipant',
      _ij3o2h1q.Exercise => 'Exercise',
      _iu06qsr2.ExerciseAlternative => 'ExerciseAlternative',
      _i64c2fru.ExerciseEquipment => 'ExerciseEquipment',
      _iqbnnuq3.ExerciseMuscle => 'ExerciseMuscle',
      _i92yp22h.ExercisePoint => 'ExercisePoint',
      _imhmmzbr.ExternalEventCache => 'ExternalEventCache',
      _i1g08zve.FormAnalysis => 'FormAnalysis',
      _i85mqlmj.FormMetric => 'FormMetric',
      _i4yrss3y.FormResult => 'FormResult',
      _inpsb4xt.GymException => 'GymException',
      _i4who45y.MaintenanceIssue => 'MaintenanceIssue',
      _im0mslp7.MemberSummary => 'MemberSummary',
      _io46uma7.MuscleGroup => 'MuscleGroup',
      _irt10kca.Notification => 'Notification',
      _ijosjbbk.PlanDetail => 'PlanDetail',
      _ibymmiv6.ReadinessPoint => 'ReadinessPoint',
      _izqv72qt.SessionDetail => 'SessionDetail',
      _imb18de8.Society => 'Society',
      _isihw7hu.SocietyEquipment => 'SocietyEquipment',
      _iolaa93q.SocietyMembership => 'SocietyMembership',
      _izoaoiwz.TrainingReadiness => 'TrainingReadiness',
      _ir2mn8w1.UserProfile => 'UserProfile',
      _ibmdzv6r.WorkoutPlan => 'WorkoutPlan',
      _ikhy8p9s.WorkoutPlanItem => 'WorkoutPlanItem',
      _ic5tnsvc.WorkoutSession => 'WorkoutSession',
      _ia8z1hbl.WorkoutSet => 'WorkoutSet',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('gymos2.', '');
    }

    switch (data) {
      case _iqygks5s.AdminStats():
        return 'AdminStats';
      case _i5uera5m.AgentAction():
        return 'AgentAction';
      case _ixlrnuhd.AgentConversation():
        return 'AgentConversation';
      case _ips3h0rm.AgentMessage():
        return 'AgentMessage';
      case _igee92io.AgentReply():
        return 'AgentReply';
      case _inypuiwd.CommunityEvent():
        return 'CommunityEvent';
      case _irt0lj0o.DashboardData():
        return 'DashboardData';
      case _i79facbx.DiscoverData():
        return 'DiscoverData';
      case _i4uc3nar.EquipmentCatalog():
        return 'EquipmentCatalog';
      case _i5ye7mcz.EventParticipant():
        return 'EventParticipant';
      case _ij3o2h1q.Exercise():
        return 'Exercise';
      case _iu06qsr2.ExerciseAlternative():
        return 'ExerciseAlternative';
      case _i64c2fru.ExerciseEquipment():
        return 'ExerciseEquipment';
      case _iqbnnuq3.ExerciseMuscle():
        return 'ExerciseMuscle';
      case _i92yp22h.ExercisePoint():
        return 'ExercisePoint';
      case _imhmmzbr.ExternalEventCache():
        return 'ExternalEventCache';
      case _i1g08zve.FormAnalysis():
        return 'FormAnalysis';
      case _i85mqlmj.FormMetric():
        return 'FormMetric';
      case _i4yrss3y.FormResult():
        return 'FormResult';
      case _inpsb4xt.GymException():
        return 'GymException';
      case _i4who45y.MaintenanceIssue():
        return 'MaintenanceIssue';
      case _im0mslp7.MemberSummary():
        return 'MemberSummary';
      case _io46uma7.MuscleGroup():
        return 'MuscleGroup';
      case _irt10kca.Notification():
        return 'Notification';
      case _ijosjbbk.PlanDetail():
        return 'PlanDetail';
      case _ibymmiv6.ReadinessPoint():
        return 'ReadinessPoint';
      case _izqv72qt.SessionDetail():
        return 'SessionDetail';
      case _imb18de8.Society():
        return 'Society';
      case _isihw7hu.SocietyEquipment():
        return 'SocietyEquipment';
      case _iolaa93q.SocietyMembership():
        return 'SocietyMembership';
      case _izoaoiwz.TrainingReadiness():
        return 'TrainingReadiness';
      case _ir2mn8w1.UserProfile():
        return 'UserProfile';
      case _ibmdzv6r.WorkoutPlan():
        return 'WorkoutPlan';
      case _ikhy8p9s.WorkoutPlanItem():
        return 'WorkoutPlanItem';
      case _ic5tnsvc.WorkoutSession():
        return 'WorkoutSession';
      case _ia8z1hbl.WorkoutSet():
        return 'WorkoutSet';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AdminStats') {
      return deserialize<_iqygks5s.AdminStats>(data['data']);
    }
    if (dataClassName == 'AgentAction') {
      return deserialize<_i5uera5m.AgentAction>(data['data']);
    }
    if (dataClassName == 'AgentConversation') {
      return deserialize<_ixlrnuhd.AgentConversation>(data['data']);
    }
    if (dataClassName == 'AgentMessage') {
      return deserialize<_ips3h0rm.AgentMessage>(data['data']);
    }
    if (dataClassName == 'AgentReply') {
      return deserialize<_igee92io.AgentReply>(data['data']);
    }
    if (dataClassName == 'CommunityEvent') {
      return deserialize<_inypuiwd.CommunityEvent>(data['data']);
    }
    if (dataClassName == 'DashboardData') {
      return deserialize<_irt0lj0o.DashboardData>(data['data']);
    }
    if (dataClassName == 'DiscoverData') {
      return deserialize<_i79facbx.DiscoverData>(data['data']);
    }
    if (dataClassName == 'EquipmentCatalog') {
      return deserialize<_i4uc3nar.EquipmentCatalog>(data['data']);
    }
    if (dataClassName == 'EventParticipant') {
      return deserialize<_i5ye7mcz.EventParticipant>(data['data']);
    }
    if (dataClassName == 'Exercise') {
      return deserialize<_ij3o2h1q.Exercise>(data['data']);
    }
    if (dataClassName == 'ExerciseAlternative') {
      return deserialize<_iu06qsr2.ExerciseAlternative>(data['data']);
    }
    if (dataClassName == 'ExerciseEquipment') {
      return deserialize<_i64c2fru.ExerciseEquipment>(data['data']);
    }
    if (dataClassName == 'ExerciseMuscle') {
      return deserialize<_iqbnnuq3.ExerciseMuscle>(data['data']);
    }
    if (dataClassName == 'ExercisePoint') {
      return deserialize<_i92yp22h.ExercisePoint>(data['data']);
    }
    if (dataClassName == 'ExternalEventCache') {
      return deserialize<_imhmmzbr.ExternalEventCache>(data['data']);
    }
    if (dataClassName == 'FormAnalysis') {
      return deserialize<_i1g08zve.FormAnalysis>(data['data']);
    }
    if (dataClassName == 'FormMetric') {
      return deserialize<_i85mqlmj.FormMetric>(data['data']);
    }
    if (dataClassName == 'FormResult') {
      return deserialize<_i4yrss3y.FormResult>(data['data']);
    }
    if (dataClassName == 'GymException') {
      return deserialize<_inpsb4xt.GymException>(data['data']);
    }
    if (dataClassName == 'MaintenanceIssue') {
      return deserialize<_i4who45y.MaintenanceIssue>(data['data']);
    }
    if (dataClassName == 'MemberSummary') {
      return deserialize<_im0mslp7.MemberSummary>(data['data']);
    }
    if (dataClassName == 'MuscleGroup') {
      return deserialize<_io46uma7.MuscleGroup>(data['data']);
    }
    if (dataClassName == 'Notification') {
      return deserialize<_irt10kca.Notification>(data['data']);
    }
    if (dataClassName == 'PlanDetail') {
      return deserialize<_ijosjbbk.PlanDetail>(data['data']);
    }
    if (dataClassName == 'ReadinessPoint') {
      return deserialize<_ibymmiv6.ReadinessPoint>(data['data']);
    }
    if (dataClassName == 'SessionDetail') {
      return deserialize<_izqv72qt.SessionDetail>(data['data']);
    }
    if (dataClassName == 'Society') {
      return deserialize<_imb18de8.Society>(data['data']);
    }
    if (dataClassName == 'SocietyEquipment') {
      return deserialize<_isihw7hu.SocietyEquipment>(data['data']);
    }
    if (dataClassName == 'SocietyMembership') {
      return deserialize<_iolaa93q.SocietyMembership>(data['data']);
    }
    if (dataClassName == 'TrainingReadiness') {
      return deserialize<_izoaoiwz.TrainingReadiness>(data['data']);
    }
    if (dataClassName == 'UserProfile') {
      return deserialize<_ir2mn8w1.UserProfile>(data['data']);
    }
    if (dataClassName == 'WorkoutPlan') {
      return deserialize<_ibmdzv6r.WorkoutPlan>(data['data']);
    }
    if (dataClassName == 'WorkoutPlanItem') {
      return deserialize<_ikhy8p9s.WorkoutPlanItem>(data['data']);
    }
    if (dataClassName == 'WorkoutSession') {
      return deserialize<_ic5tnsvc.WorkoutSession>(data['data']);
    }
    if (dataClassName == 'WorkoutSet') {
      return deserialize<_ia8z1hbl.WorkoutSet>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('gymos2', this);
    _iacs.Protocol().registerHostProtocol('gymos2', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i5uera5m.AgentAction:
        return _i5uera5m.AgentAction.t;
      case _ixlrnuhd.AgentConversation:
        return _ixlrnuhd.AgentConversation.t;
      case _ips3h0rm.AgentMessage:
        return _ips3h0rm.AgentMessage.t;
      case _inypuiwd.CommunityEvent:
        return _inypuiwd.CommunityEvent.t;
      case _i4uc3nar.EquipmentCatalog:
        return _i4uc3nar.EquipmentCatalog.t;
      case _i5ye7mcz.EventParticipant:
        return _i5ye7mcz.EventParticipant.t;
      case _ij3o2h1q.Exercise:
        return _ij3o2h1q.Exercise.t;
      case _iu06qsr2.ExerciseAlternative:
        return _iu06qsr2.ExerciseAlternative.t;
      case _i64c2fru.ExerciseEquipment:
        return _i64c2fru.ExerciseEquipment.t;
      case _iqbnnuq3.ExerciseMuscle:
        return _iqbnnuq3.ExerciseMuscle.t;
      case _imhmmzbr.ExternalEventCache:
        return _imhmmzbr.ExternalEventCache.t;
      case _i1g08zve.FormAnalysis:
        return _i1g08zve.FormAnalysis.t;
      case _i85mqlmj.FormMetric:
        return _i85mqlmj.FormMetric.t;
      case _i4who45y.MaintenanceIssue:
        return _i4who45y.MaintenanceIssue.t;
      case _io46uma7.MuscleGroup:
        return _io46uma7.MuscleGroup.t;
      case _irt10kca.Notification:
        return _irt10kca.Notification.t;
      case _imb18de8.Society:
        return _imb18de8.Society.t;
      case _isihw7hu.SocietyEquipment:
        return _isihw7hu.SocietyEquipment.t;
      case _iolaa93q.SocietyMembership:
        return _iolaa93q.SocietyMembership.t;
      case _izoaoiwz.TrainingReadiness:
        return _izoaoiwz.TrainingReadiness.t;
      case _ir2mn8w1.UserProfile:
        return _ir2mn8w1.UserProfile.t;
      case _ibmdzv6r.WorkoutPlan:
        return _ibmdzv6r.WorkoutPlan.t;
      case _ikhy8p9s.WorkoutPlanItem:
        return _ikhy8p9s.WorkoutPlanItem.t;
      case _ic5tnsvc.WorkoutSession:
        return _ic5tnsvc.WorkoutSession.t;
      case _ia8z1hbl.WorkoutSet:
        return _ia8z1hbl.WorkoutSet.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'gymos2';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
