/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:gymos2_server/src/generated/form_metric.dart' as _itbundlj;
import 'package:gymos2_server/src/generated/future_calls.dart' as _ivaevo6u;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../endpoints/admin_endpoint.dart' as _i5t1w2d2;
import '../endpoints/agent_endpoint.dart' as _ik1xrao3;
import '../endpoints/dashboard_endpoint.dart' as _ibmx856o;
import '../endpoints/equipment_endpoint.dart' as _i0p8ajg3;
import '../endpoints/event_endpoint.dart' as _icw8lb6p;
import '../endpoints/exercise_endpoint.dart' as _i3wx4cto;
import '../endpoints/form_endpoint.dart' as _iu9vr0om;
import '../endpoints/notification_endpoint.dart' as _ihb11yhk;
import '../endpoints/profile_endpoint.dart' as _i2cx2pww;
import '../endpoints/workout_endpoint.dart' as _iz7dfffa;
export 'future_calls.dart' show ServerpodFutureCallsGetter;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'admin': _i5t1w2d2.AdminEndpoint()
        ..initialize(
          server,
          'admin',
          null,
        ),
      'agent': _ik1xrao3.AgentEndpoint()
        ..initialize(
          server,
          'agent',
          null,
        ),
      'dashboard': _ibmx856o.DashboardEndpoint()
        ..initialize(
          server,
          'dashboard',
          null,
        ),
      'equipment': _i0p8ajg3.EquipmentEndpoint()
        ..initialize(
          server,
          'equipment',
          null,
        ),
      'event': _icw8lb6p.EventEndpoint()
        ..initialize(
          server,
          'event',
          null,
        ),
      'exercise': _i3wx4cto.ExerciseEndpoint()
        ..initialize(
          server,
          'exercise',
          null,
        ),
      'form': _iu9vr0om.FormEndpoint()
        ..initialize(
          server,
          'form',
          null,
        ),
      'notification': _ihb11yhk.NotificationEndpoint()
        ..initialize(
          server,
          'notification',
          null,
        ),
      'profile': _i2cx2pww.ProfileEndpoint()
        ..initialize(
          server,
          'profile',
          null,
        ),
      'workout': _iz7dfffa.WorkoutEndpoint()
        ..initialize(
          server,
          'workout',
          null,
        ),
    };
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['admin'] = _is.EndpointConnector(
      name: 'admin',
      endpoint: endpoints['admin']!,
      methodConnectors: {
        'stats': _is.MethodConnector(
          name: 'stats',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i5t1w2d2.AdminEndpoint).stats(
                session,
              ),
        ),
        'members': _is.MethodConnector(
          name: 'members',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i5t1w2d2.AdminEndpoint)
                  .members(session),
        ),
        'updateMember': _is.MethodConnector(
          name: 'updateMember',
          params: {
            'profileId': _is.ParameterDescription(
              name: 'profileId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'role': _is.ParameterDescription(
              name: 'role',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'active': _is.ParameterDescription(
              name: 'active',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i5t1w2d2.AdminEndpoint).updateMember(
                    session,
                    params['profileId'],
                    params['role'],
                    params['active'],
                  ),
        ),
      },
    );
    connectors['agent'] = _is.EndpointConnector(
      name: 'agent',
      endpoint: endpoints['agent']!,
      methodConnectors: {
        'sendMessage': _is.MethodConnector(
          name: 'sendMessage',
          params: {
            'text': _is.ParameterDescription(
              name: 'text',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'conversationId': _is.ParameterDescription(
              name: 'conversationId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['agent'] as _ik1xrao3.AgentEndpoint).sendMessage(
                    session,
                    params['text'],
                    params['conversationId'],
                  ),
        ),
        'conversations': _is.MethodConnector(
          name: 'conversations',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['agent'] as _ik1xrao3.AgentEndpoint)
                  .conversations(session),
        ),
        'messages': _is.MethodConnector(
          name: 'messages',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['agent'] as _ik1xrao3.AgentEndpoint).messages(
                    session,
                    params['id'],
                  ),
        ),
      },
    );
    connectors['dashboard'] = _is.EndpointConnector(
      name: 'dashboard',
      endpoint: endpoints['dashboard']!,
      methodConnectors: {
        'getSummary': _is.MethodConnector(
          name: 'getSummary',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _ibmx856o.DashboardEndpoint)
                  .getSummary(session),
        ),
      },
    );
    connectors['equipment'] = _is.EndpointConnector(
      name: 'equipment',
      endpoint: endpoints['equipment']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['equipment'] as _i0p8ajg3.EquipmentEndpoint)
                  .list(session),
        ),
        'catalog': _is.MethodConnector(
          name: 'catalog',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['equipment'] as _i0p8ajg3.EquipmentEndpoint)
                  .catalog(session),
        ),
        'save': _is.MethodConnector(
          name: 'save',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'catalogId': _is.ParameterDescription(
              name: 'catalogId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'label': _is.ParameterDescription(
              name: 'label',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'quantity': _is.ParameterDescription(
              name: 'quantity',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'location': _is.ParameterDescription(
              name: 'location',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['equipment'] as _i0p8ajg3.EquipmentEndpoint).save(
                    session,
                    params['id'],
                    params['catalogId'],
                    params['label'],
                    params['quantity'],
                    params['status'],
                    params['location'],
                  ),
        ),
        'report': _is.MethodConnector(
          name: 'report',
          params: {
            'equipmentId': _is.ParameterDescription(
              name: 'equipmentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'severity': _is.ParameterDescription(
              name: 'severity',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['equipment'] as _i0p8ajg3.EquipmentEndpoint)
                  .report(
                    session,
                    params['equipmentId'],
                    params['title'],
                    params['description'],
                    params['severity'],
                  ),
        ),
        'issues': _is.MethodConnector(
          name: 'issues',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['equipment'] as _i0p8ajg3.EquipmentEndpoint)
                  .issues(session),
        ),
        'updateIssue': _is.MethodConnector(
          name: 'updateIssue',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['equipment'] as _i0p8ajg3.EquipmentEndpoint)
                  .updateIssue(
                    session,
                    params['id'],
                    params['status'],
                  ),
        ),
        'watch': _is.MethodStreamConnector(
          name: 'watch',
          params: {},
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['equipment'] as _i0p8ajg3.EquipmentEndpoint)
                  .watch(session),
        ),
      },
    );
    connectors['event'] = _is.EndpointConnector(
      name: 'event',
      endpoint: endpoints['event']!,
      methodConnectors: {
        'discover': _is.MethodConnector(
          name: 'discover',
          params: {
            'city': _is.ParameterDescription(
              name: 'city',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'category': _is.ParameterDescription(
              name: 'category',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['event'] as _icw8lb6p.EventEndpoint).discover(
                    session,
                    params['city'],
                    params['category'],
                  ),
        ),
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'category': _is.ParameterDescription(
              name: 'category',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'start': _is.ParameterDescription(
              name: 'start',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'end': _is.ParameterDescription(
              name: 'end',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'latitude': _is.ParameterDescription(
              name: 'latitude',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'longitude': _is.ParameterDescription(
              name: 'longitude',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'venue': _is.ParameterDescription(
              name: 'venue',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'capacity': _is.ParameterDescription(
              name: 'capacity',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _icw8lb6p.EventEndpoint).create(
                session,
                params['title'],
                params['description'],
                params['category'],
                params['start'],
                params['end'],
                params['latitude'],
                params['longitude'],
                params['venue'],
                params['capacity'],
              ),
        ),
        'participantCount': _is.MethodConnector(
          name: 'participantCount',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _icw8lb6p.EventEndpoint)
                  .participantCount(
                    session,
                    params['id'],
                  ),
        ),
        'join': _is.MethodConnector(
          name: 'join',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'join': _is.ParameterDescription(
              name: 'join',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _icw8lb6p.EventEndpoint).join(
                session,
                params['id'],
                params['join'],
              ),
        ),
      },
    );
    connectors['exercise'] = _is.EndpointConnector(
      name: 'exercise',
      endpoint: endpoints['exercise']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['exercise'] as _i3wx4cto.ExerciseEndpoint).list(
                    session,
                    params['query'],
                  ),
        ),
      },
    );
    connectors['form'] = _is.EndpointConnector(
      name: 'form',
      endpoint: endpoints['form']!,
      methodConnectors: {
        'save': _is.MethodConnector(
          name: 'save',
          params: {
            'exerciseId': _is.ParameterDescription(
              name: 'exerciseId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'checkpoint': _is.ParameterDescription(
              name: 'checkpoint',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'confidence': _is.ParameterDescription(
              name: 'confidence',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'metrics': _is.ParameterDescription(
              name: 'metrics',
              type: _is.getType<List<_itbundlj.FormMetric>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['form'] as _iu9vr0om.FormEndpoint).save(
                session,
                params['exerciseId'],
                params['checkpoint'],
                params['confidence'],
                params['metrics'],
              ),
        ),
        'history': _is.MethodConnector(
          name: 'history',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['form'] as _iu9vr0om.FormEndpoint).history(
                session,
              ),
        ),
        'detail': _is.MethodConnector(
          name: 'detail',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['form'] as _iu9vr0om.FormEndpoint).detail(
                session,
                params['id'],
              ),
        ),
      },
    );
    connectors['notification'] = _is.EndpointConnector(
      name: 'notification',
      endpoint: endpoints['notification']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _ihb11yhk.NotificationEndpoint)
                      .list(session),
        ),
        'unreadCount': _is.MethodConnector(
          name: 'unreadCount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _ihb11yhk.NotificationEndpoint)
                      .unreadCount(session),
        ),
        'markAllRead': _is.MethodConnector(
          name: 'markAllRead',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _ihb11yhk.NotificationEndpoint)
                      .markAllRead(session),
        ),
      },
    );
    connectors['profile'] = _is.EndpointConnector(
      name: 'profile',
      endpoint: endpoints['profile']!,
      methodConnectors: {
        'getMe': _is.MethodConnector(
          name: 'getMe',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i2cx2pww.ProfileEndpoint)
                  .getMe(session),
        ),
        'completeOnboarding': _is.MethodConnector(
          name: 'completeOnboarding',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'inviteCode': _is.ParameterDescription(
              name: 'inviteCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'createDemo': _is.ParameterDescription(
              name: 'createDemo',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'experience': _is.ParameterDescription(
              name: 'experience',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'goal': _is.ParameterDescription(
              name: 'goal',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'duration': _is.ParameterDescription(
              name: 'duration',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i2cx2pww.ProfileEndpoint)
                  .completeOnboarding(
                    session,
                    params['name'],
                    params['inviteCode'],
                    params['createDemo'],
                    params['experience'],
                    params['goal'],
                    params['duration'],
                  ),
        ),
        'updatePreferences': _is.MethodConnector(
          name: 'updatePreferences',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'experience': _is.ParameterDescription(
              name: 'experience',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'goal': _is.ParameterDescription(
              name: 'goal',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'duration': _is.ParameterDescription(
              name: 'duration',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i2cx2pww.ProfileEndpoint)
                  .updatePreferences(
                    session,
                    params['name'],
                    params['experience'],
                    params['goal'],
                    params['duration'],
                  ),
        ),
        'getSociety': _is.MethodConnector(
          name: 'getSociety',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i2cx2pww.ProfileEndpoint)
                  .getSociety(session),
        ),
        'getMembers': _is.MethodConnector(
          name: 'getMembers',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i2cx2pww.ProfileEndpoint)
                  .getMembers(session),
        ),
      },
    );
    connectors['workout'] = _is.EndpointConnector(
      name: 'workout',
      endpoint: endpoints['workout']!,
      methodConnectors: {
        'generate': _is.MethodConnector(
          name: 'generate',
          params: {
            'minutes': _is.ParameterDescription(
              name: 'minutes',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'focus': _is.ParameterDescription(
              name: 'focus',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['workout'] as _iz7dfffa.WorkoutEndpoint).generate(
                    session,
                    params['minutes'],
                    params['focus'],
                  ),
        ),
        'getPlan': _is.MethodConnector(
          name: 'getPlan',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['workout'] as _iz7dfffa.WorkoutEndpoint).getPlan(
                    session,
                    params['id'],
                  ),
        ),
        'plans': _is.MethodConnector(
          name: 'plans',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['workout'] as _iz7dfffa.WorkoutEndpoint)
                  .plans(session),
        ),
        'alternatives': _is.MethodConnector(
          name: 'alternatives',
          params: {
            'exerciseId': _is.ParameterDescription(
              name: 'exerciseId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['workout'] as _iz7dfffa.WorkoutEndpoint)
                  .alternatives(
                    session,
                    params['exerciseId'],
                  ),
        ),
        'replace': _is.MethodConnector(
          name: 'replace',
          params: {
            'planId': _is.ParameterDescription(
              name: 'planId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'itemId': _is.ParameterDescription(
              name: 'itemId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'exerciseId': _is.ParameterDescription(
              name: 'exerciseId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['workout'] as _iz7dfffa.WorkoutEndpoint).replace(
                    session,
                    params['planId'],
                    params['itemId'],
                    params['exerciseId'],
                  ),
        ),
        'start': _is.MethodConnector(
          name: 'start',
          params: {
            'planId': _is.ParameterDescription(
              name: 'planId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['workout'] as _iz7dfffa.WorkoutEndpoint).start(
                    session,
                    params['planId'],
                  ),
        ),
        'logSet': _is.MethodConnector(
          name: 'logSet',
          params: {
            'sessionId': _is.ParameterDescription(
              name: 'sessionId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'exerciseId': _is.ParameterDescription(
              name: 'exerciseId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'setNumber': _is.ParameterDescription(
              name: 'setNumber',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'reps': _is.ParameterDescription(
              name: 'reps',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'weightKg': _is.ParameterDescription(
              name: 'weightKg',
              type: _is.getType<double?>(),
              nullable: true,
            ),
            'durationSec': _is.ParameterDescription(
              name: 'durationSec',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'rpe': _is.ParameterDescription(
              name: 'rpe',
              type: _is.getType<double?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['workout'] as _iz7dfffa.WorkoutEndpoint).logSet(
                    session,
                    params['sessionId'],
                    params['exerciseId'],
                    params['setNumber'],
                    params['reps'],
                    params['weightKg'],
                    params['durationSec'],
                    params['rpe'],
                  ),
        ),
        'deleteSet': _is.MethodConnector(
          name: 'deleteSet',
          params: {
            'setId': _is.ParameterDescription(
              name: 'setId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['workout'] as _iz7dfffa.WorkoutEndpoint).deleteSet(
                    session,
                    params['setId'],
                  ),
        ),
        'finish': _is.MethodConnector(
          name: 'finish',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'notes': _is.ParameterDescription(
              name: 'notes',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'effort': _is.ParameterDescription(
              name: 'effort',
              type: _is.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['workout'] as _iz7dfffa.WorkoutEndpoint).finish(
                    session,
                    params['id'],
                    params['notes'],
                    params['effort'],
                  ),
        ),
        'history': _is.MethodConnector(
          name: 'history',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['workout'] as _iz7dfffa.WorkoutEndpoint)
                  .history(session),
        ),
        'detail': _is.MethodConnector(
          name: 'detail',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['workout'] as _iz7dfffa.WorkoutEndpoint).detail(
                    session,
                    params['id'],
                  ),
        ),
        'readiness': _is.MethodConnector(
          name: 'readiness',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['workout'] as _iz7dfffa.WorkoutEndpoint)
                  .readiness(session),
        ),
        'loggedExercises': _is.MethodConnector(
          name: 'loggedExercises',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['workout'] as _iz7dfffa.WorkoutEndpoint)
                  .loggedExercises(session),
        ),
        'exerciseTrend': _is.MethodConnector(
          name: 'exerciseTrend',
          params: {
            'exerciseId': _is.ParameterDescription(
              name: 'exerciseId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['workout'] as _iz7dfffa.WorkoutEndpoint)
                  .exerciseTrend(
                    session,
                    params['exerciseId'],
                  ),
        ),
        'readinessTrend': _is.MethodConnector(
          name: 'readinessTrend',
          params: {
            'days': _is.ParameterDescription(
              name: 'days',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'utcOffsetMinutes': _is.ParameterDescription(
              name: 'utcOffsetMinutes',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['workout'] as _iz7dfffa.WorkoutEndpoint)
                  .readinessTrend(
                    session,
                    params['days'],
                    params['utcOffsetMinutes'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }

  @override
  _is.FutureCallDispatch? get futureCalls {
    return _ivaevo6u.FutureCalls();
  }
}
