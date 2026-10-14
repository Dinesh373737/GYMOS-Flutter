import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'client.dart';
import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeClient();
  runApp(
    // A new generation (after switching servers) rebuilds the router and all
    // providers against the new client.
    ValueListenableBuilder<int>(
      valueListenable: appGeneration,
      builder: (context, generation, _) =>
          ProviderScope(key: ValueKey(generation), child: const GymApp()),
    ),
  );
}
