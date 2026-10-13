BEGIN;

--
-- Function: gen_random_uuid_v7()
-- Source: https://gist.github.com/kjmph/5bd772b2c2df145aa645b837da7eca74
-- License: MIT (copyright notice included on the generator source code).
--
create or replace function gen_random_uuid_v7()
returns uuid
as $$
begin
  -- use random v4 uuid as starting point (which has the same variant we need)
  -- then overlay timestamp
  -- then set version 7 by flipping the 2 and 1 bit in the version 4 string
  return encode(
    set_bit(
      set_bit(
        overlay(uuid_send(gen_random_uuid())
                placing substring(int8send(floor(extract(epoch from clock_timestamp()) * 1000)::bigint) from 3)
                from 1 for 6
        ),
        52, 1
      ),
      53, 1
    ),
    'hex')::uuid;
end
$$
language plpgsql
volatile;

--
-- Class AgentAction as table agent_action
--
CREATE TABLE "agent_action" (
    "id" bigserial PRIMARY KEY,
    "conversationId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "toolName" text NOT NULL,
    "requestSummary" text NOT NULL,
    "resultSummary" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "durationMs" bigint NOT NULL
);

-- Indexes
CREATE INDEX "agent_action_lookup" ON "agent_action" USING btree ("conversationId");

--
-- Class AgentConversation as table agent_conversation
--
CREATE TABLE "agent_conversation" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "title" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "agent_conversation_lookup" ON "agent_conversation" USING btree ("userId");

--
-- Class AgentMessage as table agent_message
--
CREATE TABLE "agent_message" (
    "id" bigserial PRIMARY KEY,
    "conversationId" bigint NOT NULL,
    "role" text NOT NULL,
    "content" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "agent_message_lookup" ON "agent_message" USING btree ("conversationId");

--
-- Class CommunityEvent as table community_event
--
CREATE TABLE "community_event" (
    "id" bigserial PRIMARY KEY,
    "societyId" bigint NOT NULL,
    "organizerUserId" bigint NOT NULL,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "category" text NOT NULL,
    "startsAt" timestamp without time zone NOT NULL,
    "endsAt" timestamp without time zone NOT NULL,
    "latitude" double precision NOT NULL,
    "longitude" double precision NOT NULL,
    "venueLabel" text NOT NULL,
    "capacity" bigint NOT NULL,
    "status" text NOT NULL,
    "isDemo" boolean NOT NULL
);

-- Indexes
CREATE INDEX "community_event_lookup" ON "community_event" USING btree ("societyId");

--
-- Class EquipmentCatalog as table equipment_catalog
--
CREATE TABLE "equipment_catalog" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "category" text NOT NULL,
    "description" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "equipment_catalog_unique" ON "equipment_catalog" USING btree ("name");

--
-- Class EventParticipant as table event_participant
--
CREATE TABLE "event_participant" (
    "id" bigserial PRIMARY KEY,
    "eventId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "joinedAt" timestamp without time zone NOT NULL,
    "status" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "event_participant_unique" ON "event_participant" USING btree ("eventId", "userId");

--
-- Class Exercise as table exercise
--
CREATE TABLE "exercise" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "slug" text NOT NULL,
    "instructions" text NOT NULL,
    "difficulty" text NOT NULL,
    "movementPattern" text NOT NULL,
    "exerciseType" text NOT NULL,
    "defaultDurationMin" bigint NOT NULL,
    "isActive" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "exercise_unique" ON "exercise" USING btree ("slug");
CREATE INDEX "exercise_lookup" ON "exercise" USING btree ("name");

--
-- Class ExerciseAlternative as table exercise_alternative
--
CREATE TABLE "exercise_alternative" (
    "id" bigserial PRIMARY KEY,
    "sourceExerciseId" bigint NOT NULL,
    "alternativeExerciseId" bigint NOT NULL,
    "similarityScore" double precision NOT NULL,
    "notes" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "exercise_alternative_unique" ON "exercise_alternative" USING btree ("sourceExerciseId", "alternativeExerciseId");

--
-- Class ExerciseEquipment as table exercise_equipment
--
CREATE TABLE "exercise_equipment" (
    "id" bigserial PRIMARY KEY,
    "exerciseId" bigint NOT NULL,
    "equipmentId" bigint NOT NULL,
    "required" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "exercise_equipment_unique" ON "exercise_equipment" USING btree ("exerciseId", "equipmentId");

--
-- Class ExerciseMuscle as table exercise_muscle
--
CREATE TABLE "exercise_muscle" (
    "id" bigserial PRIMARY KEY,
    "exerciseId" bigint NOT NULL,
    "muscleGroupId" bigint NOT NULL,
    "contribution" double precision NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "exercise_muscle_unique" ON "exercise_muscle" USING btree ("exerciseId", "muscleGroupId");

--
-- Class ExternalEventCache as table external_event_cache
--
CREATE TABLE "external_event_cache" (
    "id" bigserial PRIMARY KEY,
    "provider" text NOT NULL,
    "providerEventId" text NOT NULL,
    "queryKey" text NOT NULL,
    "title" text NOT NULL,
    "category" text NOT NULL,
    "startsAt" timestamp without time zone NOT NULL,
    "endsAt" timestamp without time zone,
    "latitude" double precision,
    "longitude" double precision,
    "venueLabel" text NOT NULL,
    "organizerName" text,
    "imageUrl" text,
    "sourceUrl" text NOT NULL,
    "rawHash" text NOT NULL,
    "fetchedAt" timestamp without time zone NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "external_event_cache_lookup" ON "external_event_cache" USING btree ("provider");
CREATE INDEX "external_event_cache_query" ON "external_event_cache" USING btree ("queryKey", "startsAt");
CREATE UNIQUE INDEX "external_event_cache_unique" ON "external_event_cache" USING btree ("provider", "queryKey", "providerEventId");

--
-- Class FormAnalysis as table form_analysis
--
CREATE TABLE "form_analysis" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "exerciseId" bigint NOT NULL,
    "checkpoint" text NOT NULL,
    "capturedAt" timestamp without time zone NOT NULL,
    "analysisType" text NOT NULL,
    "resultBand" text NOT NULL,
    "confidence" double precision NOT NULL,
    "summary" text NOT NULL,
    "retainedImagePath" text
);

-- Indexes
CREATE INDEX "form_analysis_lookup" ON "form_analysis" USING btree ("userId");

--
-- Class FormMetric as table form_metric
--
CREATE TABLE "form_metric" (
    "id" bigserial PRIMARY KEY,
    "formAnalysisId" bigint NOT NULL,
    "metricName" text NOT NULL,
    "measuredValue" double precision NOT NULL,
    "unit" text NOT NULL,
    "targetRangeText" text NOT NULL,
    "status" text NOT NULL,
    "confidence" double precision NOT NULL,
    "cue" text NOT NULL
);

-- Indexes
CREATE INDEX "form_metric_lookup" ON "form_metric" USING btree ("formAnalysisId");

--
-- Class MaintenanceIssue as table maintenance_issue
--
CREATE TABLE "maintenance_issue" (
    "id" bigserial PRIMARY KEY,
    "societyId" bigint NOT NULL,
    "societyEquipmentId" bigint NOT NULL,
    "reportedBy" bigint NOT NULL,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "severity" text NOT NULL,
    "status" text NOT NULL,
    "photoPath" text,
    "createdAt" timestamp without time zone NOT NULL,
    "resolvedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "maintenance_issue_lookup" ON "maintenance_issue" USING btree ("societyId");

--
-- Class MuscleGroup as table muscle_group
--
CREATE TABLE "muscle_group" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "bodyArea" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "muscle_group_unique" ON "muscle_group" USING btree ("name");

--
-- Class Notification as table notification
--
CREATE TABLE "notification" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "type" text NOT NULL,
    "title" text NOT NULL,
    "body" text NOT NULL,
    "link" text,
    "readAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "notification_lookup" ON "notification" USING btree ("userId");
CREATE INDEX "notification_recent" ON "notification" USING btree ("userId", "createdAt");

--
-- Class Society as table society
--
CREATE TABLE "society" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "addressLabel" text NOT NULL,
    "inviteCode" text NOT NULL,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "isActive" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "society_unique" ON "society" USING btree ("inviteCode");
CREATE INDEX "society_lookup" ON "society" USING btree ("name");

--
-- Class SocietyEquipment as table society_equipment
--
CREATE TABLE "society_equipment" (
    "id" bigserial PRIMARY KEY,
    "societyId" bigint NOT NULL,
    "equipmentId" bigint NOT NULL,
    "label" text NOT NULL,
    "quantity" bigint NOT NULL,
    "status" text NOT NULL,
    "locationLabel" text NOT NULL,
    "lastServicedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "society_equipment_lookup" ON "society_equipment" USING btree ("societyId");

--
-- Class SocietyMembership as table society_membership
--
CREATE TABLE "society_membership" (
    "id" bigserial PRIMARY KEY,
    "societyId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "role" text NOT NULL,
    "joinedAt" timestamp without time zone NOT NULL,
    "isActive" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "society_membership_unique" ON "society_membership" USING btree ("societyId", "userId");

--
-- Class TrainingReadiness as table training_readiness
--
CREATE TABLE "training_readiness" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "muscleGroupId" bigint NOT NULL,
    "muscleName" text NOT NULL,
    "trainingLoadScore" double precision NOT NULL,
    "readinessBand" text NOT NULL,
    "lastTrainedAt" timestamp without time zone,
    "computedAt" timestamp without time zone NOT NULL,
    "explanation" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "training_readiness_unique" ON "training_readiness" USING btree ("userId", "muscleGroupId");

--
-- Class UserProfile as table user_profile
--
CREATE TABLE "user_profile" (
    "id" bigserial PRIMARY KEY,
    "authUserId" text NOT NULL,
    "displayName" text NOT NULL,
    "role" text NOT NULL,
    "societyId" bigint NOT NULL,
    "experienceLevel" text NOT NULL,
    "primaryGoal" text NOT NULL,
    "preferredWorkoutDuration" bigint NOT NULL,
    "onboardingComplete" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "user_profile_unique" ON "user_profile" USING btree ("authUserId");

--
-- Class WorkoutPlan as table workout_plan
--
CREATE TABLE "workout_plan" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "title" text NOT NULL,
    "createdByType" text NOT NULL,
    "target" text NOT NULL,
    "plannedDurationMin" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "status" text NOT NULL
);

-- Indexes
CREATE INDEX "workout_plan_lookup" ON "workout_plan" USING btree ("userId");

--
-- Class WorkoutPlanItem as table workout_plan_item
--
CREATE TABLE "workout_plan_item" (
    "id" bigserial PRIMARY KEY,
    "planId" bigint NOT NULL,
    "exerciseId" bigint NOT NULL,
    "orderIndex" bigint NOT NULL,
    "targetSets" bigint NOT NULL,
    "targetRepsText" text NOT NULL,
    "suggestedWeight" double precision,
    "restSeconds" bigint NOT NULL,
    "rationale" text NOT NULL
);

-- Indexes
CREATE INDEX "workout_plan_item_lookup" ON "workout_plan_item" USING btree ("planId");

--
-- Class WorkoutSession as table workout_session
--
CREATE TABLE "workout_session" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "planId" bigint NOT NULL,
    "title" text NOT NULL,
    "startedAt" timestamp without time zone NOT NULL,
    "endedAt" timestamp without time zone,
    "durationMin" bigint,
    "notes" text NOT NULL,
    "perceivedEffort" double precision
);

-- Indexes
CREATE INDEX "workout_session_lookup" ON "workout_session" USING btree ("userId");

--
-- Class WorkoutSet as table workout_set
--
CREATE TABLE "workout_set" (
    "id" bigserial PRIMARY KEY,
    "sessionId" bigint NOT NULL,
    "exerciseId" bigint NOT NULL,
    "setNumber" bigint NOT NULL,
    "reps" bigint,
    "weightKg" double precision,
    "durationSec" bigint,
    "rpe" double precision,
    "completedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "workout_set_lookup" ON "workout_set" USING btree ("sessionId");
CREATE UNIQUE INDEX "workout_set_identity" ON "workout_set" USING btree ("sessionId", "exerciseId", "setNumber");

--
-- Class CloudStorageEntry as table serverpod_cloud_storage
--
CREATE TABLE "serverpod_cloud_storage" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "addedTime" timestamp without time zone NOT NULL,
    "expiration" timestamp without time zone,
    "byteData" bytea NOT NULL,
    "verified" boolean NOT NULL,
    "contentType" text,
    "cacheControl" text,
    "contentDisposition" text,
    "contentEncoding" text,
    "customMetadata" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_path_idx" ON "serverpod_cloud_storage" USING btree ("storageId", "path");
CREATE INDEX "serverpod_cloud_storage_expiration" ON "serverpod_cloud_storage" USING btree ("expiration");

--
-- Class CloudStorageDirectDownloadEntry as table serverpod_cloud_storage_direct_download
--
CREATE TABLE "serverpod_cloud_storage_direct_download" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL,
    "downloadFileName" text,
    "contentType" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_download_auth_key" ON "serverpod_cloud_storage_direct_download" USING btree ("authKey");
CREATE INDEX "serverpod_cloud_storage_direct_download_expiration" ON "serverpod_cloud_storage_direct_download" USING btree ("expiration");

--
-- Class CloudStorageDirectUploadEntry as table serverpod_cloud_storage_direct_upload
--
CREATE TABLE "serverpod_cloud_storage_direct_upload" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL,
    "maxFileSize" bigint NOT NULL DEFAULT 10485760,
    "contentLength" bigint,
    "preventOverwrite" boolean NOT NULL DEFAULT false,
    "contentType" text,
    "cacheControl" text,
    "contentDisposition" text,
    "contentEncoding" text,
    "customMetadata" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_upload_storage_path" ON "serverpod_cloud_storage_direct_upload" USING btree ("storageId", "path");

--
-- Class FutureCallEntry as table serverpod_future_call
--
CREATE TABLE "serverpod_future_call" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "serializedObject" text,
    "serverId" text NOT NULL,
    "identifier" text,
    "scheduling" json
);

-- Indexes
CREATE INDEX "serverpod_future_call_time_idx" ON "serverpod_future_call" USING btree ("time");
CREATE INDEX "serverpod_future_call_serverId_idx" ON "serverpod_future_call" USING btree ("serverId");
CREATE INDEX "serverpod_future_call_identifier_idx" ON "serverpod_future_call" USING btree ("identifier");

--
-- Class FutureCallClaimEntry as table serverpod_future_call_claim
--
CREATE TABLE "serverpod_future_call_claim" (
    "id" bigserial PRIMARY KEY,
    "futureCallId" bigint,
    "lastHeartbeatTime" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "future_call_unique_idx" ON "serverpod_future_call_claim" USING btree ("futureCallId");

--
-- Class ServerHealthConnectionInfo as table serverpod_health_connection_info
--
CREATE TABLE "serverpod_health_connection_info" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "active" bigint NOT NULL,
    "closing" bigint NOT NULL,
    "idle" bigint NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_connection_info_timestamp_idx" ON "serverpod_health_connection_info" USING btree ("timestamp", "serverId", "granularity");

--
-- Class ServerHealthMetric as table serverpod_health_metric
--
CREATE TABLE "serverpod_health_metric" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "isHealthy" boolean NOT NULL,
    "value" double precision NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_metric_timestamp_idx" ON "serverpod_health_metric" USING btree ("timestamp", "serverId", "name", "granularity");

--
-- Class LogEntry as table serverpod_log
--
CREATE TABLE "serverpod_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "reference" text,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "logLevel" bigint NOT NULL,
    "message" text NOT NULL,
    "error" text,
    "stackTrace" text,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_log_sessionLogId_idx" ON "serverpod_log" USING btree ("sessionLogId", "order");

--
-- Class MessageLogEntry as table serverpod_message_log
--
CREATE TABLE "serverpod_message_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "serverId" text NOT NULL,
    "messageId" bigint NOT NULL,
    "endpoint" text NOT NULL,
    "messageName" text NOT NULL,
    "duration" double precision NOT NULL,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_message_log_sessionLogId_idx" ON "serverpod_message_log" USING btree ("sessionLogId", "order");

--
-- Class MethodInfo as table serverpod_method
--
CREATE TABLE "serverpod_method" (
    "id" bigserial PRIMARY KEY,
    "endpoint" text NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_method_endpoint_method_idx" ON "serverpod_method" USING btree ("endpoint", "method");

--
-- Class DatabaseMigrationVersion as table serverpod_migrations
--
CREATE TABLE "serverpod_migrations" (
    "id" bigserial PRIMARY KEY,
    "module" text NOT NULL,
    "version" text NOT NULL,
    "timestamp" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_migrations_ids" ON "serverpod_migrations" USING btree ("module");

--
-- Class QueryLogEntry as table serverpod_query_log
--
CREATE TABLE "serverpod_query_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "query" text NOT NULL,
    "duration" double precision NOT NULL,
    "numRows" bigint,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_query_log_sessionLogId_idx" ON "serverpod_query_log" USING btree ("sessionLogId", "order");

--
-- Class ReadWriteTestEntry as table serverpod_readwrite_test
--
CREATE TABLE "serverpod_readwrite_test" (
    "id" bigserial PRIMARY KEY,
    "number" bigint NOT NULL
);

--
-- Class RuntimeSettings as table serverpod_runtime_settings
--
CREATE TABLE "serverpod_runtime_settings" (
    "id" bigserial PRIMARY KEY,
    "logSettings" json NOT NULL,
    "logSettingsOverrides" json NOT NULL,
    "logServiceCalls" boolean NOT NULL,
    "logMalformedCalls" boolean NOT NULL
);

--
-- Class SessionLogEntry as table serverpod_session_log
--
CREATE TABLE "serverpod_session_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "module" text,
    "endpoint" text,
    "method" text,
    "duration" double precision,
    "numQueries" bigint,
    "slow" boolean,
    "error" text,
    "stackTrace" text,
    "authenticatedUserId" bigint,
    "userId" text,
    "isOpen" boolean,
    "touched" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_session_log_serverid_idx" ON "serverpod_session_log" USING btree ("serverId");
CREATE INDEX "serverpod_session_log_time_idx" ON "serverpod_session_log" USING btree ("time");
CREATE INDEX "serverpod_session_log_touched_idx" ON "serverpod_session_log" USING btree ("touched");
CREATE INDEX "serverpod_session_log_isopen_idx" ON "serverpod_session_log" USING btree ("isOpen");

--
-- Class AnonymousAccount as table serverpod_auth_idp_anonymous_account
--
CREATE TABLE "serverpod_auth_idp_anonymous_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- Class AppleAccount as table serverpod_auth_idp_apple_account
--
CREATE TABLE "serverpod_auth_idp_apple_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "userIdentifier" text NOT NULL,
    "refreshToken" text NOT NULL,
    "refreshTokenRequestedWithBundleIdentifier" boolean NOT NULL,
    "lastRefreshedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "email" text,
    "isEmailVerified" boolean,
    "isPrivateEmail" boolean,
    "firstName" text,
    "lastName" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_apple_account_identifier" ON "serverpod_auth_idp_apple_account" USING btree ("userIdentifier");

--
-- Class EmailAccount as table serverpod_auth_idp_email_account
--
CREATE TABLE "serverpod_auth_idp_email_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "email" text NOT NULL,
    "passwordHash" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_email_account_email" ON "serverpod_auth_idp_email_account" USING btree ("email");

--
-- Class EmailAccountPasswordResetRequest as table serverpod_auth_idp_email_account_password_reset_request
--
CREATE TABLE "serverpod_auth_idp_email_account_password_reset_request" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "emailAccountId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "challengeId" uuid NOT NULL,
    "setPasswordChallengeId" uuid
);

--
-- Class EmailAccountRequest as table serverpod_auth_idp_email_account_request
--
CREATE TABLE "serverpod_auth_idp_email_account_request" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" text NOT NULL,
    "challengeId" uuid NOT NULL,
    "createAccountChallengeId" uuid
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_email_account_request_email" ON "serverpod_auth_idp_email_account_request" USING btree ("email");

--
-- Class FacebookAccount as table serverpod_auth_idp_facebook_account
--
CREATE TABLE "serverpod_auth_idp_facebook_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "fullName" text,
    "firstName" text,
    "lastName" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_facebook_account_user_identifier" ON "serverpod_auth_idp_facebook_account" USING btree ("userIdentifier");

--
-- Class FirebaseAccount as table serverpod_auth_idp_firebase_account
--
CREATE TABLE "serverpod_auth_idp_firebase_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "created" timestamp without time zone NOT NULL,
    "email" text,
    "phone" text,
    "userIdentifier" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_firebase_account_user_identifier" ON "serverpod_auth_idp_firebase_account" USING btree ("userIdentifier");

--
-- Class GitHubAccount as table serverpod_auth_idp_github_account
--
CREATE TABLE "serverpod_auth_idp_github_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "created" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_github_account_user_identifier" ON "serverpod_auth_idp_github_account" USING btree ("userIdentifier");

--
-- Class GoogleAccount as table serverpod_auth_idp_google_account
--
CREATE TABLE "serverpod_auth_idp_google_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "created" timestamp without time zone NOT NULL,
    "email" text NOT NULL,
    "userIdentifier" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_google_account_user_identifier" ON "serverpod_auth_idp_google_account" USING btree ("userIdentifier");

--
-- Class MicrosoftAccount as table serverpod_auth_idp_microsoft_account
--
CREATE TABLE "serverpod_auth_idp_microsoft_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "created" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_microsoft_account_user_identifier" ON "serverpod_auth_idp_microsoft_account" USING btree ("userIdentifier");

--
-- Class PasskeyAccount as table serverpod_auth_idp_passkey_account
--
CREATE TABLE "serverpod_auth_idp_passkey_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "keyId" bytea NOT NULL,
    "keyIdBase64" text NOT NULL,
    "clientDataJSON" bytea NOT NULL,
    "attestationObject" bytea NOT NULL,
    "originalChallenge" bytea NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_passkey_account_key_id_base64" ON "serverpod_auth_idp_passkey_account" USING btree ("keyIdBase64");

--
-- Class PasskeyChallenge as table serverpod_auth_idp_passkey_challenge
--
CREATE TABLE "serverpod_auth_idp_passkey_challenge" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL,
    "challenge" bytea NOT NULL
);

--
-- Class RateLimitedRequestAttempt as table serverpod_auth_idp_rate_limited_request_attempt
--
CREATE TABLE "serverpod_auth_idp_rate_limited_request_attempt" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "domain" text NOT NULL,
    "source" text NOT NULL,
    "key" text NOT NULL,
    "ipAddress" text,
    "attemptedAt" timestamp without time zone NOT NULL,
    "extraData" json
);

-- Indexes
CREATE INDEX "serverpod_auth_idp_rate_limited_request_attempt_composite" ON "serverpod_auth_idp_rate_limited_request_attempt" USING btree ("domain", "source", "key", "attemptedAt");

--
-- Class SecretChallenge as table serverpod_auth_idp_secret_challenge
--
CREATE TABLE "serverpod_auth_idp_secret_challenge" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "challengeCodeHash" text NOT NULL
);

--
-- Class RefreshToken as table serverpod_auth_core_jwt_refresh_token
--
CREATE TABLE "serverpod_auth_core_jwt_refresh_token" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "scopeNames" json NOT NULL,
    "extraClaims" text,
    "method" text NOT NULL,
    "fixedSecret" bytea NOT NULL,
    "rotatingSecretHash" text NOT NULL,
    "lastUpdatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "serverpod_auth_core_jwt_refresh_token_last_updated_at" ON "serverpod_auth_core_jwt_refresh_token" USING btree ("lastUpdatedAt");

--
-- Class UserProfile as table serverpod_auth_core_profile
--
CREATE TABLE "serverpod_auth_core_profile" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userName" text,
    "fullName" text,
    "email" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "imageId" uuid
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_profile_user_profile_email_auth_user_id" ON "serverpod_auth_core_profile" USING btree ("authUserId");

--
-- Class UserProfileImage as table serverpod_auth_core_profile_image
--
CREATE TABLE "serverpod_auth_core_profile_image" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "userProfileId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "url" text NOT NULL
);

--
-- Class ServerSideSession as table serverpod_auth_core_session
--
CREATE TABLE "serverpod_auth_core_session" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "scopeNames" json NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastUsedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" timestamp without time zone,
    "expireAfterUnusedFor" bigint,
    "sessionKeyHash" bytea NOT NULL,
    "sessionKeySalt" bytea NOT NULL,
    "method" text NOT NULL
);

--
-- Class AuthUser as table serverpod_auth_core_user
--
CREATE TABLE "serverpod_auth_core_user" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL,
    "scopeNames" json NOT NULL,
    "blocked" boolean NOT NULL
);

--
-- Foreign relations for "agent_action" table
--
ALTER TABLE ONLY "agent_action"
    ADD CONSTRAINT "agent_action_fk_0"
    FOREIGN KEY("conversationId")
    REFERENCES "agent_conversation"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "agent_action"
    ADD CONSTRAINT "agent_action_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "user_profile"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "agent_conversation" table
--
ALTER TABLE ONLY "agent_conversation"
    ADD CONSTRAINT "agent_conversation_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user_profile"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "agent_message" table
--
ALTER TABLE ONLY "agent_message"
    ADD CONSTRAINT "agent_message_fk_0"
    FOREIGN KEY("conversationId")
    REFERENCES "agent_conversation"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "community_event" table
--
ALTER TABLE ONLY "community_event"
    ADD CONSTRAINT "community_event_fk_0"
    FOREIGN KEY("societyId")
    REFERENCES "society"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "community_event"
    ADD CONSTRAINT "community_event_fk_1"
    FOREIGN KEY("organizerUserId")
    REFERENCES "user_profile"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "event_participant" table
--
ALTER TABLE ONLY "event_participant"
    ADD CONSTRAINT "event_participant_fk_0"
    FOREIGN KEY("eventId")
    REFERENCES "community_event"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "event_participant"
    ADD CONSTRAINT "event_participant_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "user_profile"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "exercise_alternative" table
--
ALTER TABLE ONLY "exercise_alternative"
    ADD CONSTRAINT "exercise_alternative_fk_0"
    FOREIGN KEY("sourceExerciseId")
    REFERENCES "exercise"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "exercise_alternative"
    ADD CONSTRAINT "exercise_alternative_fk_1"
    FOREIGN KEY("alternativeExerciseId")
    REFERENCES "exercise"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "exercise_equipment" table
--
ALTER TABLE ONLY "exercise_equipment"
    ADD CONSTRAINT "exercise_equipment_fk_0"
    FOREIGN KEY("exerciseId")
    REFERENCES "exercise"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "exercise_equipment"
    ADD CONSTRAINT "exercise_equipment_fk_1"
    FOREIGN KEY("equipmentId")
    REFERENCES "equipment_catalog"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "exercise_muscle" table
--
ALTER TABLE ONLY "exercise_muscle"
    ADD CONSTRAINT "exercise_muscle_fk_0"
    FOREIGN KEY("exerciseId")
    REFERENCES "exercise"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "exercise_muscle"
    ADD CONSTRAINT "exercise_muscle_fk_1"
    FOREIGN KEY("muscleGroupId")
    REFERENCES "muscle_group"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "form_analysis" table
--
ALTER TABLE ONLY "form_analysis"
    ADD CONSTRAINT "form_analysis_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user_profile"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "form_analysis"
    ADD CONSTRAINT "form_analysis_fk_1"
    FOREIGN KEY("exerciseId")
    REFERENCES "exercise"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "form_metric" table
--
ALTER TABLE ONLY "form_metric"
    ADD CONSTRAINT "form_metric_fk_0"
    FOREIGN KEY("formAnalysisId")
    REFERENCES "form_analysis"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "maintenance_issue" table
--
ALTER TABLE ONLY "maintenance_issue"
    ADD CONSTRAINT "maintenance_issue_fk_0"
    FOREIGN KEY("societyId")
    REFERENCES "society"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "maintenance_issue"
    ADD CONSTRAINT "maintenance_issue_fk_1"
    FOREIGN KEY("societyEquipmentId")
    REFERENCES "society_equipment"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "maintenance_issue"
    ADD CONSTRAINT "maintenance_issue_fk_2"
    FOREIGN KEY("reportedBy")
    REFERENCES "user_profile"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "notification" table
--
ALTER TABLE ONLY "notification"
    ADD CONSTRAINT "notification_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user_profile"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "society_equipment" table
--
ALTER TABLE ONLY "society_equipment"
    ADD CONSTRAINT "society_equipment_fk_0"
    FOREIGN KEY("societyId")
    REFERENCES "society"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "society_equipment"
    ADD CONSTRAINT "society_equipment_fk_1"
    FOREIGN KEY("equipmentId")
    REFERENCES "equipment_catalog"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "society_membership" table
--
ALTER TABLE ONLY "society_membership"
    ADD CONSTRAINT "society_membership_fk_0"
    FOREIGN KEY("societyId")
    REFERENCES "society"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "society_membership"
    ADD CONSTRAINT "society_membership_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "user_profile"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "training_readiness" table
--
ALTER TABLE ONLY "training_readiness"
    ADD CONSTRAINT "training_readiness_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user_profile"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "training_readiness"
    ADD CONSTRAINT "training_readiness_fk_1"
    FOREIGN KEY("muscleGroupId")
    REFERENCES "muscle_group"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "user_profile" table
--
ALTER TABLE ONLY "user_profile"
    ADD CONSTRAINT "user_profile_fk_0"
    FOREIGN KEY("societyId")
    REFERENCES "society"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "workout_plan" table
--
ALTER TABLE ONLY "workout_plan"
    ADD CONSTRAINT "workout_plan_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user_profile"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "workout_plan_item" table
--
ALTER TABLE ONLY "workout_plan_item"
    ADD CONSTRAINT "workout_plan_item_fk_0"
    FOREIGN KEY("planId")
    REFERENCES "workout_plan"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "workout_plan_item"
    ADD CONSTRAINT "workout_plan_item_fk_1"
    FOREIGN KEY("exerciseId")
    REFERENCES "exercise"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "workout_session" table
--
ALTER TABLE ONLY "workout_session"
    ADD CONSTRAINT "workout_session_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user_profile"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "workout_session"
    ADD CONSTRAINT "workout_session_fk_1"
    FOREIGN KEY("planId")
    REFERENCES "workout_plan"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "workout_set" table
--
ALTER TABLE ONLY "workout_set"
    ADD CONSTRAINT "workout_set_fk_0"
    FOREIGN KEY("sessionId")
    REFERENCES "workout_session"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "workout_set"
    ADD CONSTRAINT "workout_set_fk_1"
    FOREIGN KEY("exerciseId")
    REFERENCES "exercise"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_future_call_claim" table
--
ALTER TABLE ONLY "serverpod_future_call_claim"
    ADD CONSTRAINT "serverpod_future_call_claim_fk_0"
    FOREIGN KEY("futureCallId")
    REFERENCES "serverpod_future_call"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_log" table
--
ALTER TABLE ONLY "serverpod_log"
    ADD CONSTRAINT "serverpod_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_message_log" table
--
ALTER TABLE ONLY "serverpod_message_log"
    ADD CONSTRAINT "serverpod_message_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_query_log" table
--
ALTER TABLE ONLY "serverpod_query_log"
    ADD CONSTRAINT "serverpod_query_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_anonymous_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_anonymous_account"
    ADD CONSTRAINT "serverpod_auth_idp_anonymous_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_apple_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_apple_account"
    ADD CONSTRAINT "serverpod_auth_idp_apple_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account_password_reset_request" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_0"
    FOREIGN KEY("emailAccountId")
    REFERENCES "serverpod_auth_idp_email_account"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_1"
    FOREIGN KEY("challengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_2"
    FOREIGN KEY("setPasswordChallengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account_request" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_request_fk_0"
    FOREIGN KEY("challengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_request_fk_1"
    FOREIGN KEY("createAccountChallengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_facebook_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_facebook_account"
    ADD CONSTRAINT "serverpod_auth_idp_facebook_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_firebase_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_firebase_account"
    ADD CONSTRAINT "serverpod_auth_idp_firebase_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_github_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_github_account"
    ADD CONSTRAINT "serverpod_auth_idp_github_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_google_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_google_account"
    ADD CONSTRAINT "serverpod_auth_idp_google_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_microsoft_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_microsoft_account"
    ADD CONSTRAINT "serverpod_auth_idp_microsoft_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_passkey_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_passkey_account"
    ADD CONSTRAINT "serverpod_auth_idp_passkey_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_jwt_refresh_token" table
--
ALTER TABLE ONLY "serverpod_auth_core_jwt_refresh_token"
    ADD CONSTRAINT "serverpod_auth_core_jwt_refresh_token_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_profile" table
--
ALTER TABLE ONLY "serverpod_auth_core_profile"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_core_profile"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_1"
    FOREIGN KEY("imageId")
    REFERENCES "serverpod_auth_core_profile_image"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    DEFERRABLE INITIALLY DEFERRED;

--
-- Foreign relations for "serverpod_auth_core_profile_image" table
--
ALTER TABLE ONLY "serverpod_auth_core_profile_image"
    ADD CONSTRAINT "serverpod_auth_core_profile_image_fk_0"
    FOREIGN KEY("userProfileId")
    REFERENCES "serverpod_auth_core_profile"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_session" table
--
ALTER TABLE ONLY "serverpod_auth_core_session"
    ADD CONSTRAINT "serverpod_auth_core_session_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR gymos2
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('gymos2', '20261013185008073', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261013185008073', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
