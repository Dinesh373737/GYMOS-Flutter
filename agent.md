# GymOS implementation status

Updated: 2026-10-14

## Submission check (2026-10-14)

- Created `docs/GymOS_2_Project_Description.docx`, a one-page, text-only project summary. Its rendered page was reviewed in Word, and the DOCX package contains no embedded images.
- Updated the README project description to explain the resident/admin flows and the roles of Flutter, Serverpod, PostgreSQL, on-device photo processing, and the server-side integrations.
- Recovered the final walkthrough export into `video/` so its README link resolves. The editable video working files are unavailable in this checkout.
- Re-ran the full Flutter test suite: 35 tests passed. `tool/setup.dart` passed Dart static analysis. No app or backend source code changed during this submission check.

## Walkthrough video (2026-10-14)

- Created [`video/GymOS-2.0-mobile-walkthrough.mp4`](video/GymOS-2.0-mobile-walkthrough.mp4): a 3:49, 1920×1080, 24 fps H.264/AAC product tour. The phone view uses real Android emulator captures; the first workout scenes include live screen recordings, with selected real frames for later sections. Short on-screen captions explain sign-up, Home, planning, workout session and set logging, Progress, Groq coach, Form Coach, Discover/external events, OpenStreetMap, equipment, Admin, Profile and notifications. No synthetic voiceover is used. The ambient instrumental was composed locally for this edit.
- The final video is included in the repository. The working capture and composition files are not present in this checkout. The exported runtime, video/audio streams, representative opening/middle/closing frames, and non-clipping soundtrack level (mean −23.0 dB, peak −10.2 dB) were checked during creation.
- The video is a feature tour, not proof of physical-device photo inference, a completed workout in this recording, or a live event join. Those boundaries remain as described below. The Parse.bot external listings are identified as a third-party wrapper, not the official AllEvents API.

This is the implementation record requested by the user. It describes existing code separately from verification results and remaining requirements. The specification is `GymOS_2_Astra_Master_Implementation_Prompt_OpenStreetMap(1).docx` (`requirements-reference.txt` is an older extraction that lacks the OpenStreetMap section).

## Implemented

- Preserved the original project and its Git history in `original-daa/`; the Serverpod rewrite lives in `gymos2/`.
- Serverpod 4.0.3 backend, generated Dart client, normalized `.spy.yaml` models, and three generated migrations. Models cover profiles, societies/memberships, exercises/muscles/equipment, maintenance, plans/sessions/sets, form metrics, events, external event cache, coach conversations/actions, notifications, and non-table DTOs for admin stats, member summaries, readiness trend points and exercise trend points.
- Serverpod email/password authentication, persisted profiles, onboarding by invite or demo-society creation, training preferences (name, experience, goal, duration), and sign-out.
- Authenticated server checks for private record ownership, society access, and admin-only mutations. Paused memberships lose access to all society endpoints.
- Catalog seed with 44 exercises and 20 equipment types. Each demo society receives 15 equipment entries, a cable machine under maintenance, and three labeled demonstration events.
- **Admin (new):** `AdminEndpoint.stats` (members, equipment health, maintenance queue, upcoming events/participants, society workouts per day for 14 days — aggregates only), `members` (role, active state, 30-day workout count) and `updateMember` (role/status changes, guarded so a society always keeps one active admin; the member is notified). Flutter Admin dashboard with stat tiles, activity chart, equipment health bars, invite-code copy and member role/pause controls.
- **Notifications (new):** in-app `Notification` records with links. Members are notified when their maintenance report changes status or their membership changes; admins are notified of new reports. `NotificationEndpoint` lists, counts and marks read; the shell shows a bell with an unread badge that refreshes on society stream events.
- **External events (new):** `ExternalEventProvider` interface plus `ParseAllEventsProvider`, a server-side adapter for the third-party Parse.bot allevents.in wrapper (not the official AllEvents API). It queries the `sports` and `health-wellness` categories, keeps fitness listings only (running, cycling, yoga, fitness, sports by keyword/category), parses the wrapper's year-less local times with city DST rules, decodes HTML entities, never invents coordinates, and maps 401/402/429/5xx/timeouts to retryable errors. `EventCacheService` caches normalized rows with a TTL (`EXTERNAL_EVENTS_CACHE_TTL_MINUTES`, default 360), dedupes concurrent refreshes, backs off after failures, and labels results `live`, `cached`, `stale`, `unavailable`, `unsupported` (wrapper covers London, New York and Tokyo only) or `unconfigured`. The coach's `search_events` tool reads cache only so a chat turn never waits on the provider.
- **Scheduled work (new):** `HousekeepingFutureCall` registered on boot as a recurring 6-hour Serverpod future call; refreshes expired external caches and prunes ended listings and old read notifications.
- Dashboard with workout totals, equipment notices, recent sessions, readiness bands and next community event.
- Deterministic workout drafts constrained by duration/focus, experience, equipment, and high recent load. Goal changes selection and targets; recent frequency, form attention and (new) **recently skipped exercises** (planned but not logged in finished sessions) lower an exercise's rank, with a rationale line.
- Start/resume workout, save/update/delete sets, finish with overall effort and notes, reopen history. New: **previous-session reference** per exercise ("Last time"), **in-session exercise swap** for exercises with no logged sets (server-checked), a finish summary with duration/sets/exercises/effort and per-exercise volume change vs. last time, and readiness rows persisted to `TrainingReadiness` on finish.
- **Progress (new):** readiness trend endpoint (daily decayed load, band counts and sessions for 7–60 days, using the caller's UTC offset), logged-exercise list and per-exercise trend (top weight, volume, reps per session). Progress screen shows 30-day stats, week streak, 7-day sessions chart, load-trend line chart, exercise trend chart with weight/volume toggle, readiness bars, a form-check trend per checkpoint (latest vs. previous) and session history.
- Inventory, admin equipment add/edit forms with validation, member issue reporting, admin issue transitions, and society-scoped Serverpod equipment streams.
- Groq provider abstraction with configurable model, server-only secret lookup, at most eight allowlisted tool calls, persisted conversations, and action status/duration logs.
- Mobile photo capture/import with ML Kit pose detection for squat, push-up, plank and curl checkpoints; only derived metrics are saved. Web shows history and explains mobile-only analysis.
- Discover: community events with participant counts and capacity bars, a "Going" filter, category chips, supported-city shortcuts, provider status banner, external listing cards (source link, organizer, directions when coordinates or a venue exist, "Multiple dates · until …" for running series), and the OSM map with dark-mode tiles and distinct community (lime) vs. external (sky) markers.
- **Visual redesign (new):** shared design system in `app/theme.dart` (Space Grotesk display + Inter body via `google_fonts`, layered dark surfaces, lime/mint brand gradient, violet/sky coach gradient, semantic status/band/category colors, restyled inputs, chips, sliders, sheets, dialogs, snackbars and navigation) and `core/widgets.dart` (ambient background glows, staggered fade-in pages, hover-lift panels, stat tiles, ring gauges, metric bars, icon badges, gradient avatars, shimmer loading skeletons, adaptive grids). New sidebar and floating mobile navigation, gradient "Ask GymOS" button, fade page transitions, and redesigned Auth, Onboarding (choice cards), Home, Workout (plan timeline), Session, Progress, Discover, Profile, Coach chat and Equipment screens.

- **Android release APK (new, 2026-10-14):** fixed the release-only startup crash (R8 stripped Room's generated `WorkDatabase_Impl` constructor used by WorkManager; `android/app/proguard-rules.pro` keeps it). Release builds now allow cleartext HTTP so phones can reach the development server on the local network. Branded launcher icon (legacy + adaptive), dark launch screen (no white flash), version 2.0.0+2. Phones can change the server address in the app (sign-in screen "Server · Change", Profile → Server address, and the profile-load error screen); switching signs out locally and restarts the app on a new client, and unreachable-server errors say so. `start-gymos-server.cmd` starts the backend on Windows. APKs: `releases/GymOS-2.0.0-android-arm64.apk` and `releases/GymOS-2.0.0-android-armv7.apk`, built with default server `http://192.168.0.123:8080/` and debug-signed for sideloading.

## Verification recorded

- 2026-10-14 Android: reproduced the release crash on the Pixel 7 emulator (`Failed to create an instance of androidx.work.impl.WorkDatabase`), applied the keep rules, and the rebuilt release APK (x86_64 split) launched with an empty crash buffer. It reached the server at the LAN address `192.168.0.123:8080`, signed in with the local demo account (server log: `emailIdp.login`, `profile.getMe`, `dashboard.getSummary`), and rendered Home and Discover. The final arm64/armv7 APKs were rebuilt afterwards with only a server-label text change; they were inspected with aapt (package, version 2.0.0, ABI, cleartext flag) but not installed on a physical phone. `flutter analyze`: no issues; `flutter test`: 35 passed (adds server-address normalization and connection-error tests).

- 2026-10-14: `dart analyze` (server) and `flutter analyze` (app): no issues. `dart format` applied.
- 2026-10-14: backend `dart test`: all 30 tests passed against the PostgreSQL test cluster (19 existing + 7 provider/normalization unit tests + 4 new integration tests for cache refresh/cache hit/stale fallback/back-off/unsupported/unconfigured, admin scoping and last-admin guard, paused-member lockout, maintenance notifications, readiness trend, exercise trend and previous-session sets). One more unit test (HTML entity decoding) was added afterwards; see the final-run note below.
- 2026-10-14: Flutter `flutter test`: all 32 tests passed (24 existing, updated for the skeleton loader and new chip labels, plus 8 new: auth redirect, admin visibility/aggregates/self-pause guard, Discover live/stale labeling without invented directions, Going filter with capacity, notification badge).
- 2026-10-14: the new migration `20261013185008073` applied to the development database on server start; the dev server started with the new build and served the release web app.
- 2026-10-14 live web check (local browser): signed in with the local demo account; Home, Workout (generated a plan; skipped-exercise rationale appeared), Discover (Bengaluru shown as not covered; London fetched live — server log "Cached 18 external events for London" — and rendered "LIVE · ALLEVENTS" cards; a card opened its allevents.in source page; dark OSM map rendered), Admin dashboard (live stats and member list), Progress (load-trend chart from real history) and the mobile layout rendered without server errors. That check found HTML entities in titles, past start dates on multi-date listings and a few layout nits, which were fixed afterwards.
- Earlier records: live Groq tool-based 40-minute draft; Web and Android debug OSM map checks; Android offline tile banner. The earlier release APK crash in AndroidX WorkManager initialization is fixed (see above).

## Remaining requirements and limitations

- Cloud deployment (Serverpod Cloud), production secrets/email/migrations and release signing remain pending; they need the user's cloud account.
- The APK has not been installed on a physical phone yet; iOS runtime has not been exercised. Phones need the server running on a computer on the same Wi-Fi until the backend is deployed.
- External events come from the third-party Parse.bot wrapper, which only covers London, New York and Tokyo and returns year-less display times; the official AllEvents developer API is not integrated. Banner images from the provider's CDN may not load in the web build (a category fallback is shown).
- Physical-device photo capture/inference and broader live coach follow-up scenarios remain unverified.
- Readiness is a heuristic training-load estimate, not a recovery measurement.
- Notifications are in-app only (no push/local delivery). No image upload/retention flow exists; maintenance photos are not implemented.
- Demo history is not seeded; progress fills from real logged sessions.

## Configuration and handling

- `GROQ_API_KEY` and `ALLEVENTS_API_KEY` (the Parse.bot key) stay server-side in `config/passwords.yaml` or the environment; never put values in Flutter, documentation, logs, or commits. `GROQ_MODEL` and `EXTERNAL_EVENTS_CACHE_TTL_MINUTES` are optional server environment settings.
- Local `config/passwords.yaml`, `.serverpod/`, `.env`, build outputs, `web/app` and `original-daa/` are ignored.
- The Serverpod CLI used for generation/migrations is `serverpod_cli` 4.0.3 activated with `dart pub global activate` (`%LOCALAPPDATA%\Pub\Cache\bin\serverpod.bat`).
- See `README.md` for architecture, setup, demo steps, and test commands. Update this record only as implementation and checks actually advance.
