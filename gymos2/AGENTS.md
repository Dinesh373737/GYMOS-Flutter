# Flutter & Serverpod project

This project is a Flutter app (frontend) backed by a Serverpod server (backend). Always build the app's backend with Serverpod.
Build for multiple users, use Serverpod's built-in authentication, which is already set up in `lib/server.dart`.

## GymOS application context

GymOS 2.0 is a community fitness app with authenticated society membership, equipment/maintenance, constraint-based workout plans, manually logged sets, training-load estimates, an on-device still-photo Form Coach, Groq tool calling, and community events. The Flutter UI uses Riverpod, go_router, and a custom dark Material 3 theme. Preserve the original repository in `../original-daa/`; do not rebuild its coursework visualizer or add live rep counting.

Keep `../agent.md` current with implemented features, actual verification, and remaining work; update it as checks advance, and maintain `../README.md` for setup and known limitations. Do not report untested code as verified. Recorded verification: 19 backend tests from earlier work, final Flutter analysis with no issues, all 24 Flutter tests after the OSM map migration, final release Web/Android APK builds, migrations, and a live authenticated plan/two-set/completion/history/event-join smoke flow passed. Live Groq profile/history/readiness/equipment tool calls and a persisted 40-minute draft passed earlier. Discover now uses `flutter_map` and keyless OSM tiles with linked attribution; Google Maps remains only an external Directions URL. Final Web runtime rendered real OSM tiles and two database-backed test pins, with marker/list selection, filtering, empty results, Directions, and zoom exercised. Android debug runtime rendered real OSM tiles, selected event summaries, two pins, and linked attribution; Get Directions opened Google Maps with the selected coordinates. An offline emulator check displayed the tile-failure banner while Discover stayed usable, then connectivity was restored. The Android release crash in AndroidX WorkManager `WorkDatabase` initialization was fixed on 2026-10-14 with R8 keep rules in `android/app/proguard-rules.pro`; the release APK then launched, signed in over the LAN and rendered Home/Discover on the emulator. Release builds allow cleartext HTTP for LAN development servers, and phones can change the server address in the app. The supplied event credential belongs to a third-party Parse.bot wrapper for allevents.in, not the official AllEvents developer API; `ParseAllEventsProvider` + `EventCacheService` now fetch, normalize and cache its London/New York/Tokyo fitness listings server-side, and a recurring `HousekeepingFutureCall` refreshes expired caches. On 2026-10-14, 30 backend tests and 32 Flutter tests passed after the admin/notification/trend/external-event work and the UI redesign; see `../agent.md`. Full physical-device photo and Cloud deployment verification remain pending. Photos stay on-device; only derived metrics reach the backend. Never expose secrets in generated client code, Flutter assets, docs, logs, or commits.

For this task, the user explicitly said: "Yes, start it and verify the app." That authorizes local server startup and end-to-end verification and overrides the generated no-start instruction below for this session. Prefer the MCP workflow when its tools are available; preserve the documented CLI fallback when the supervised server cannot start.

## Serverpod development workflow

The user starts the server and Flutter app with `serverpod start`. There is no need to check if the server is running: make the changes and call the `serverpod` MCP tools as needed. If the server is not running, an informative error message will be received from the MCP server. Then STOP and ask the user to start it. NEVER start the server yourself. The Flutter app is started along with it, or can be launched from the MCP tool `spawn_flutter_app`.

While running, `serverpod start` watches for file changes to run incremental code generation and hot reload both the server and the Flutter app.

Calling `serverpod generate` directly is not needed, but might be useful to troubleshoot when an incremental generation fails.

ALWAYS use the MCP server instead of the command line. Use the MCP server to:

- `create_migration` and `apply_migrations` for database (after you change data models).
- `create_repair_migration` if the database has drifted out of sync with the migrations.
- `tail_server_logs` to read logs from the server.
- `tail_flutter_logs` to read the raw stdout/stderr of the Flutter app.
- `hot_reload` / `hot_restart` to reload or restart the server and the Flutter app. ALWAYS call `hot_restart` after doing changes in the Flutter app that may not work with normal hot reload (which is automatically applied).
- `spawn_flutter_app` to start a Flutter app declared under `serverpod: flutter_apps:` in the server `pubspec.yaml`.
- `get_flutter_app_dtd` (Dart tooling daemon) for connecting to the app through the `dart` MCP.

NEVER edit generated code. The server's `lib/src/generated/` directory and the whole `gymos2_client` package are rewritten by the code generator. Change the `.spy.yaml` models, the endpoints, or `lib/server.dart` instead.

Migrations are a narrow exception: the `migration.sql` of a generated migration MAY be edited by hand when the generated SQL would lose data — to add a data transformation, or to reach a destructive change through non-destructive steps. Never touch the other files in the migration directory, and keep the schema the SQL ends up with identical to `definition.sql` — new databases are created from that file and never run `migration.sql`.

Only when the server cannot be started at all, fall back to the CLI in the server package:

- `serverpod generate` to regenerate the client and the generated server code.
- `serverpod create-migration` after changing a model with a `table` (add `--force` for destructive changes). It only writes the migration; `serverpod start` applies pending migrations when it boots the server.

Tests use PostgreSQL. The generated embedded-database workflow normally uses `database.dataPath`, without Docker. The current Windows `config/test.yaml` instead uses a separately bootstrapped test cluster at localhost:9090, database `gymos2_test`; the integration test has passed against it. Check the current config and ensure that cluster is running before tests. Run `dart test` in the server package; unit tests can be targeted independently of database setup. Record fresh test results after changes.

Windows verification notes: stop the development server before backend tests to avoid an `argon2.dll` lock. Do not initialize/recreate the existing test cluster. `../README.md` documents its cached PostgreSQL startup command. The bundled Serverpod 4.0.3 executable successfully starts development with `start --no-tui --no-flutter --no-watch` when the launcher wrapper fails; the user's authorization above covers this local verification fallback.

Checklist after doing changes, in this order:

- `dart analyze` (CLI)
- `dart format` (CLI)
- `create_migration` and `apply_migrations` (MCP - only if necessary)
- Do `serverpod` MCP `hot_restart` if required (hot reload is done automatically). Will also hot restart Flutter app
- Run tests, if applicable (`dart test` in the server package)
- Check `serverpod` MCP `tail_server_logs` and `tail_flutter_logs` for any issues.

If the user asks you to test the app:

1. Use `get_flutter_app_dtd` (`serverpod` MCP) to get the Flutter app's DTD
2. Pass the DTD to `connect_dart_tooling_daemon` (`dart` MCP) to connect to the app
3. Use `flutter_driver` (`dart` MCP) to navigate through the app

The app is launched from `gymos2_flutter/lib/driver.dart`, which starts the Flutter driver extension with text entry emulation turned off so the app stays usable by hand. To let the driver type, set `enableTextEntryEmulation: true` there and `hot_restart` the app.
