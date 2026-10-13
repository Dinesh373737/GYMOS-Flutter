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
import 'dart:async' as _ida;
import 'package:gymos2_client/src/protocol/admin_stats.dart' as _ivah111o;
import 'package:gymos2_client/src/protocol/agent_conversation.dart'
    as _ia02a612;
import 'package:gymos2_client/src/protocol/agent_message.dart' as _i5udvepv;
import 'package:gymos2_client/src/protocol/agent_reply.dart' as _istt1pdk;
import 'package:gymos2_client/src/protocol/community_event.dart' as _i7q9k7r8;
import 'package:gymos2_client/src/protocol/dashboard_data.dart' as _i0ijh81b;
import 'package:gymos2_client/src/protocol/discover_data.dart' as _i0kedfti;
import 'package:gymos2_client/src/protocol/equipment_catalog.dart' as _iw7yyjnv;
import 'package:gymos2_client/src/protocol/exercise.dart' as _ictweu0g;
import 'package:gymos2_client/src/protocol/exercise_point.dart' as _i8fkiqtq;
import 'package:gymos2_client/src/protocol/form_analysis.dart' as _ionbffjy;
import 'package:gymos2_client/src/protocol/form_metric.dart' as _imrk6sq9;
import 'package:gymos2_client/src/protocol/form_result.dart' as _ibrbbocq;
import 'package:gymos2_client/src/protocol/maintenance_issue.dart' as _iz3dszao;
import 'package:gymos2_client/src/protocol/member_summary.dart' as _ipdotjts;
import 'package:gymos2_client/src/protocol/notification.dart' as _i8lewh08;
import 'package:gymos2_client/src/protocol/plan_detail.dart' as _i7i5u3mx;
import 'package:gymos2_client/src/protocol/readiness_point.dart' as _itxsft30;
import 'package:gymos2_client/src/protocol/session_detail.dart' as _ilby4xke;
import 'package:gymos2_client/src/protocol/society.dart' as _ip7p08n3;
import 'package:gymos2_client/src/protocol/society_equipment.dart' as _i6wmn40d;
import 'package:gymos2_client/src/protocol/training_readiness.dart'
    as _ib2poron;
import 'package:gymos2_client/src/protocol/user_profile.dart' as _ioaxpban;
import 'package:gymos2_client/src/protocol/workout_plan.dart' as _i14z15uo;
import 'package:gymos2_client/src/protocol/workout_session.dart' as _ijjiocb7;
import 'package:gymos2_client/src/protocol/workout_set.dart' as _i8xrf00u;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// Society administration. Every method is scoped to the caller's own society
/// and requires an active admin membership. Admins see aggregate activity
/// only, never members' private workout or form records.
/// {@category Endpoint}
class EndpointAdmin extends _isc.EndpointRef {
  EndpointAdmin(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'admin';

  _ida.Future<_ivah111o.AdminStats> stats() =>
      caller.callServerEndpoint<_ivah111o.AdminStats>(
        'admin',
        'stats',
        {},
      );

  _ida.Future<List<_ipdotjts.MemberSummary>> members() =>
      caller.callServerEndpoint<List<_ipdotjts.MemberSummary>>(
        'admin',
        'members',
        {},
      );

  _ida.Future<_ipdotjts.MemberSummary> updateMember(
    int profileId,
    String role,
    bool active,
  ) => caller.callServerEndpoint<_ipdotjts.MemberSummary>(
    'admin',
    'updateMember',
    {
      'profileId': profileId,
      'role': role,
      'active': active,
    },
  );
}

/// {@category Endpoint}
class EndpointAgent extends _isc.EndpointRef {
  EndpointAgent(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'agent';

  _ida.Future<_istt1pdk.AgentReply> sendMessage(
    String text,
    int? conversationId,
  ) => caller.callServerEndpoint<_istt1pdk.AgentReply>(
    'agent',
    'sendMessage',
    {
      'text': text,
      'conversationId': conversationId,
    },
  );

  _ida.Future<List<_ia02a612.AgentConversation>> conversations() =>
      caller.callServerEndpoint<List<_ia02a612.AgentConversation>>(
        'agent',
        'conversations',
        {},
      );

  _ida.Future<List<_i5udvepv.AgentMessage>> messages(int id) =>
      caller.callServerEndpoint<List<_i5udvepv.AgentMessage>>(
        'agent',
        'messages',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointDashboard extends _isc.EndpointRef {
  EndpointDashboard(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dashboard';

  _ida.Future<_i0ijh81b.DashboardData> getSummary() =>
      caller.callServerEndpoint<_i0ijh81b.DashboardData>(
        'dashboard',
        'getSummary',
        {},
      );
}

/// {@category Endpoint}
class EndpointEquipment extends _isc.EndpointRef {
  EndpointEquipment(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'equipment';

  _ida.Future<List<_i6wmn40d.SocietyEquipment>> list() =>
      caller.callServerEndpoint<List<_i6wmn40d.SocietyEquipment>>(
        'equipment',
        'list',
        {},
      );

  _ida.Future<List<_iw7yyjnv.EquipmentCatalog>> catalog() =>
      caller.callServerEndpoint<List<_iw7yyjnv.EquipmentCatalog>>(
        'equipment',
        'catalog',
        {},
      );

  _ida.Future<_i6wmn40d.SocietyEquipment> save(
    int? id,
    int catalogId,
    String label,
    int quantity,
    String status,
    String location,
  ) => caller.callServerEndpoint<_i6wmn40d.SocietyEquipment>(
    'equipment',
    'save',
    {
      'id': id,
      'catalogId': catalogId,
      'label': label,
      'quantity': quantity,
      'status': status,
      'location': location,
    },
  );

  _ida.Stream<_i6wmn40d.SocietyEquipment> watch() =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_i6wmn40d.SocietyEquipment>,
        _i6wmn40d.SocietyEquipment
      >(
        'equipment',
        'watch',
        {},
        {},
      );

  _ida.Future<_iz3dszao.MaintenanceIssue> report(
    int equipmentId,
    String title,
    String description,
    String severity,
  ) => caller.callServerEndpoint<_iz3dszao.MaintenanceIssue>(
    'equipment',
    'report',
    {
      'equipmentId': equipmentId,
      'title': title,
      'description': description,
      'severity': severity,
    },
  );

  _ida.Future<List<_iz3dszao.MaintenanceIssue>> issues() =>
      caller.callServerEndpoint<List<_iz3dszao.MaintenanceIssue>>(
        'equipment',
        'issues',
        {},
      );

  _ida.Future<_iz3dszao.MaintenanceIssue> updateIssue(
    int id,
    String status,
  ) => caller.callServerEndpoint<_iz3dszao.MaintenanceIssue>(
    'equipment',
    'updateIssue',
    {
      'id': id,
      'status': status,
    },
  );
}

/// {@category Endpoint}
class EndpointEvent extends _isc.EndpointRef {
  EndpointEvent(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'event';

  _ida.Future<_i0kedfti.DiscoverData> discover(
    String city,
    String category,
  ) => caller.callServerEndpoint<_i0kedfti.DiscoverData>(
    'event',
    'discover',
    {
      'city': city,
      'category': category,
    },
  );

  _ida.Future<_i7q9k7r8.CommunityEvent> create(
    String title,
    String description,
    String category,
    DateTime start,
    DateTime end,
    double latitude,
    double longitude,
    String venue,
    int capacity,
  ) => caller.callServerEndpoint<_i7q9k7r8.CommunityEvent>(
    'event',
    'create',
    {
      'title': title,
      'description': description,
      'category': category,
      'start': start,
      'end': end,
      'latitude': latitude,
      'longitude': longitude,
      'venue': venue,
      'capacity': capacity,
    },
  );

  _ida.Future<int> participantCount(int id) => caller.callServerEndpoint<int>(
    'event',
    'participantCount',
    {'id': id},
  );

  _ida.Future<void> join(
    int id,
    bool join,
  ) => caller.callServerEndpoint<void>(
    'event',
    'join',
    {
      'id': id,
      'join': join,
    },
  );
}

/// {@category Endpoint}
class EndpointExercise extends _isc.EndpointRef {
  EndpointExercise(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'exercise';

  _ida.Future<List<_ictweu0g.Exercise>> list(String query) =>
      caller.callServerEndpoint<List<_ictweu0g.Exercise>>(
        'exercise',
        'list',
        {'query': query},
      );
}

/// {@category Endpoint}
class EndpointForm extends _isc.EndpointRef {
  EndpointForm(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'form';

  _ida.Future<_ibrbbocq.FormResult> save(
    int exerciseId,
    String checkpoint,
    double confidence,
    List<_imrk6sq9.FormMetric> metrics,
  ) => caller.callServerEndpoint<_ibrbbocq.FormResult>(
    'form',
    'save',
    {
      'exerciseId': exerciseId,
      'checkpoint': checkpoint,
      'confidence': confidence,
      'metrics': metrics,
    },
  );

  _ida.Future<List<_ionbffjy.FormAnalysis>> history() =>
      caller.callServerEndpoint<List<_ionbffjy.FormAnalysis>>(
        'form',
        'history',
        {},
      );

  _ida.Future<_ibrbbocq.FormResult> detail(int id) =>
      caller.callServerEndpoint<_ibrbbocq.FormResult>(
        'form',
        'detail',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointNotification extends _isc.EndpointRef {
  EndpointNotification(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'notification';

  _ida.Future<List<_i8lewh08.Notification>> list() =>
      caller.callServerEndpoint<List<_i8lewh08.Notification>>(
        'notification',
        'list',
        {},
      );

  _ida.Future<int> unreadCount() => caller.callServerEndpoint<int>(
    'notification',
    'unreadCount',
    {},
  );

  _ida.Future<void> markAllRead() => caller.callServerEndpoint<void>(
    'notification',
    'markAllRead',
    {},
  );
}

/// {@category Endpoint}
class EndpointProfile extends _isc.EndpointRef {
  EndpointProfile(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'profile';

  _ida.Future<_ioaxpban.UserProfile?> getMe() =>
      caller.callServerEndpoint<_ioaxpban.UserProfile?>(
        'profile',
        'getMe',
        {},
      );

  _ida.Future<_ioaxpban.UserProfile> completeOnboarding(
    String name,
    String inviteCode,
    bool createDemo,
    String experience,
    String goal,
    int duration,
  ) => caller.callServerEndpoint<_ioaxpban.UserProfile>(
    'profile',
    'completeOnboarding',
    {
      'name': name,
      'inviteCode': inviteCode,
      'createDemo': createDemo,
      'experience': experience,
      'goal': goal,
      'duration': duration,
    },
  );

  _ida.Future<_ioaxpban.UserProfile> updatePreferences(
    String name,
    String experience,
    String goal,
    int duration,
  ) => caller.callServerEndpoint<_ioaxpban.UserProfile>(
    'profile',
    'updatePreferences',
    {
      'name': name,
      'experience': experience,
      'goal': goal,
      'duration': duration,
    },
  );

  _ida.Future<_ip7p08n3.Society> getSociety() =>
      caller.callServerEndpoint<_ip7p08n3.Society>(
        'profile',
        'getSociety',
        {},
      );

  _ida.Future<List<_ioaxpban.UserProfile>> getMembers() =>
      caller.callServerEndpoint<List<_ioaxpban.UserProfile>>(
        'profile',
        'getMembers',
        {},
      );
}

/// {@category Endpoint}
class EndpointWorkout extends _isc.EndpointRef {
  EndpointWorkout(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'workout';

  _ida.Future<_i7i5u3mx.PlanDetail> generate(
    int minutes,
    String focus,
  ) => caller.callServerEndpoint<_i7i5u3mx.PlanDetail>(
    'workout',
    'generate',
    {
      'minutes': minutes,
      'focus': focus,
    },
  );

  _ida.Future<_i7i5u3mx.PlanDetail> getPlan(int id) =>
      caller.callServerEndpoint<_i7i5u3mx.PlanDetail>(
        'workout',
        'getPlan',
        {'id': id},
      );

  _ida.Future<List<_i14z15uo.WorkoutPlan>> plans() =>
      caller.callServerEndpoint<List<_i14z15uo.WorkoutPlan>>(
        'workout',
        'plans',
        {},
      );

  _ida.Future<List<_ictweu0g.Exercise>> alternatives(int exerciseId) =>
      caller.callServerEndpoint<List<_ictweu0g.Exercise>>(
        'workout',
        'alternatives',
        {'exerciseId': exerciseId},
      );

  _ida.Future<_i7i5u3mx.PlanDetail> replace(
    int planId,
    int itemId,
    int exerciseId,
  ) => caller.callServerEndpoint<_i7i5u3mx.PlanDetail>(
    'workout',
    'replace',
    {
      'planId': planId,
      'itemId': itemId,
      'exerciseId': exerciseId,
    },
  );

  _ida.Future<_ijjiocb7.WorkoutSession> start(int planId) =>
      caller.callServerEndpoint<_ijjiocb7.WorkoutSession>(
        'workout',
        'start',
        {'planId': planId},
      );

  _ida.Future<_i8xrf00u.WorkoutSet> logSet(
    int sessionId,
    int exerciseId,
    int setNumber,
    int? reps,
    double? weightKg,
    int? durationSec,
    double? rpe,
  ) => caller.callServerEndpoint<_i8xrf00u.WorkoutSet>(
    'workout',
    'logSet',
    {
      'sessionId': sessionId,
      'exerciseId': exerciseId,
      'setNumber': setNumber,
      'reps': reps,
      'weightKg': weightKg,
      'durationSec': durationSec,
      'rpe': rpe,
    },
  );

  _ida.Future<void> deleteSet(int setId) => caller.callServerEndpoint<void>(
    'workout',
    'deleteSet',
    {'setId': setId},
  );

  _ida.Future<_ilby4xke.SessionDetail> finish(
    int id,
    String notes,
    double effort,
  ) => caller.callServerEndpoint<_ilby4xke.SessionDetail>(
    'workout',
    'finish',
    {
      'id': id,
      'notes': notes,
      'effort': effort,
    },
  );

  _ida.Future<List<_ijjiocb7.WorkoutSession>> history() =>
      caller.callServerEndpoint<List<_ijjiocb7.WorkoutSession>>(
        'workout',
        'history',
        {},
      );

  _ida.Future<_ilby4xke.SessionDetail> detail(int id) =>
      caller.callServerEndpoint<_ilby4xke.SessionDetail>(
        'workout',
        'detail',
        {'id': id},
      );

  _ida.Future<List<_ib2poron.TrainingReadiness>> readiness() =>
      caller.callServerEndpoint<List<_ib2poron.TrainingReadiness>>(
        'workout',
        'readiness',
        {},
      );

  /// Exercises the caller has logged in finished sessions, for trend pickers.
  _ida.Future<List<_ictweu0g.Exercise>> loggedExercises() =>
      caller.callServerEndpoint<List<_ictweu0g.Exercise>>(
        'workout',
        'loggedExercises',
        {},
      );

  /// Per-session top weight, volume and reps for one exercise, oldest first.
  _ida.Future<List<_i8fkiqtq.ExercisePoint>> exerciseTrend(int exerciseId) =>
      caller.callServerEndpoint<List<_i8fkiqtq.ExercisePoint>>(
        'workout',
        'exerciseTrend',
        {'exerciseId': exerciseId},
      );

  _ida.Future<List<_itxsft30.ReadinessPoint>> readinessTrend(
    int days,
    int utcOffsetMinutes,
  ) => caller.callServerEndpoint<List<_itxsft30.ReadinessPoint>>(
    'workout',
    'readinessTrend',
    {
      'days': days,
      'utcOffsetMinutes': utcOffsetMinutes,
    },
  );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    admin = EndpointAdmin(this);
    agent = EndpointAgent(this);
    dashboard = EndpointDashboard(this);
    equipment = EndpointEquipment(this);
    event = EndpointEvent(this);
    exercise = EndpointExercise(this);
    form = EndpointForm(this);
    notification = EndpointNotification(this);
    profile = EndpointProfile(this);
    workout = EndpointWorkout(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointAdmin admin;

  late final EndpointAgent agent;

  late final EndpointDashboard dashboard;

  late final EndpointEquipment equipment;

  late final EndpointEvent event;

  late final EndpointExercise exercise;

  late final EndpointForm form;

  late final EndpointNotification notification;

  late final EndpointProfile profile;

  late final EndpointWorkout workout;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'admin': admin,
    'agent': agent,
    'dashboard': dashboard,
    'equipment': equipment,
    'event': event,
    'exercise': exercise,
    'form': form,
    'notification': notification,
    'profile': profile,
    'workout': workout,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
