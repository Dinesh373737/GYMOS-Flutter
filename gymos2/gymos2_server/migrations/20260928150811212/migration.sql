BEGIN;

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
--
CREATE TABLE "external_event_cache" (
    "id" bigserial PRIMARY KEY,
    "provider" text NOT NULL,
    "providerEventId" text NOT NULL,
    "queryKey" text NOT NULL,
    "title" text NOT NULL,
    "category" text NOT NULL,
    "startsAt" timestamp without time zone NOT NULL,
    "latitude" double precision NOT NULL,
    "longitude" double precision NOT NULL,
    "venueLabel" text NOT NULL,
    "sourceUrl" text NOT NULL,
    "rawHash" text NOT NULL,
    "fetchedAt" timestamp without time zone NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "external_event_cache_lookup" ON "external_event_cache" USING btree ("provider");

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
--
CREATE TABLE "muscle_group" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "bodyArea" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "muscle_group_unique" ON "muscle_group" USING btree ("name");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "notification" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "type" text NOT NULL,
    "title" text NOT NULL,
    "body" text NOT NULL,
    "readAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "notification_lookup" ON "notification" USING btree ("userId");

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "agent_conversation"
    ADD CONSTRAINT "agent_conversation_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user_profile"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "agent_message"
    ADD CONSTRAINT "agent_message_fk_0"
    FOREIGN KEY("conversationId")
    REFERENCES "agent_conversation"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "form_metric"
    ADD CONSTRAINT "form_metric_fk_0"
    FOREIGN KEY("formAnalysisId")
    REFERENCES "form_analysis"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "notification"
    ADD CONSTRAINT "notification_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user_profile"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_profile"
    ADD CONSTRAINT "user_profile_fk_0"
    FOREIGN KEY("societyId")
    REFERENCES "society"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "workout_plan"
    ADD CONSTRAINT "workout_plan_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user_profile"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- MIGRATION VERSION FOR gymos2
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('gymos2', '20260928150811212', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260928150811212', "timestamp" = now();

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
