BEGIN;

--
-- ACTION ALTER TABLE
--
-- The cache is disposable; clear it so the new unique index cannot fail.
DELETE FROM "external_event_cache";
ALTER TABLE "external_event_cache" ADD COLUMN "endsAt" timestamp without time zone;
ALTER TABLE "external_event_cache" ADD COLUMN "organizerName" text;
ALTER TABLE "external_event_cache" ADD COLUMN "imageUrl" text;
ALTER TABLE "external_event_cache" ALTER COLUMN "latitude" DROP NOT NULL;
ALTER TABLE "external_event_cache" ALTER COLUMN "longitude" DROP NOT NULL;
CREATE INDEX "external_event_cache_query" ON "external_event_cache" USING btree ("queryKey", "startsAt");
CREATE UNIQUE INDEX "external_event_cache_unique" ON "external_event_cache" USING btree ("provider", "queryKey", "providerEventId");
--
-- ACTION ALTER TABLE
--
ALTER TABLE "notification" ADD COLUMN "link" text;
CREATE INDEX "notification_recent" ON "notification" USING btree ("userId", "createdAt");

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
