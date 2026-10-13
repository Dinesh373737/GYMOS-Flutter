from pathlib import Path
b=Path('gymos2')
f=b/'gymos2_flutter/android/app/build.gradle.kts';s=f.read_text();s=s.replace('minSdk = flutter.minSdkVersion','minSdk = 23');s=s.replace('versionName = flutter.versionName','versionName = flutter.versionName\n        manifestPlaceholders["GOOGLE_MAPS_API_KEY"] = providers.gradleProperty("GOOGLE_MAPS_API_KEY").orElse(providers.environmentVariable("GOOGLE_MAPS_API_KEY")).getOrElse("")');f.write_text(s)
f=b/'gymos2_flutter/android/app/src/main/AndroidManifest.xml';s=f.read_text().replace('<application','<uses-permission android:name="android.permission.INTERNET" />\n    <uses-permission android:name="android.permission.CAMERA" />\n    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />\n    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />\n    <application',1).replace('android:label="gymos2_flutter"','android:label="GymOS"').replace('android:icon="@mipmap/ic_launcher">','android:icon="@mipmap/ic_launcher">\n        <meta-data android:name="com.google.android.geo.API_KEY" android:value="${GOOGLE_MAPS_API_KEY}" />');f.write_text(s)
f=b/'gymos2_flutter/android/app/src/debug/AndroidManifest.xml';s=f.read_text().replace('</manifest>','<application android:usesCleartextTraffic="true" />\n</manifest>');f.write_text(s)
f=b/'gymos2_server/lib/src/services/workout/workout_service.dart';s=f.read_text().replace("import '../access.dart';\n",'');f.write_text(s)
f=b/'gymos2_server/lib/src/endpoints/equipment_endpoint.dart';s=f.read_text().replace('s.messages.postMessage(', 'await s.messages.postMessage(');f.write_text(s)
# Enforce idempotence for retried set writes at the database layer.
f=b/'gymos2_server/lib/src/models/workout_set.spy.yaml';s=f.read_text();s+='  workout_set_identity:\n    fields: sessionId, exerciseId, setNumber\n    unique: true\n';f.write_text(s)
# Discard only scaffold example files created during this task.
for rel in ['gymos2_flutter/lib/screens/greetings_screen.dart','gymos2_flutter/lib/screens/sign_in_screen.dart','gymos2_flutter/test/widget_test.dart','gymos2_server/lib/src/greetings/greeting.spy.yaml','gymos2_server/lib/src/greetings/greeting_endpoint.dart','gymos2_server/test/integration/greeting_endpoint_test.dart']:
 f=b/rel
 if f.exists(): f.unlink()
