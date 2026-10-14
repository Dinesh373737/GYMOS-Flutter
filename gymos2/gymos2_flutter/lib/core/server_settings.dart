import 'package:flutter/material.dart';
import '../app/theme.dart';
import '../client.dart';

/// Lets a phone user point the app at the GymOS server, e.g. the computer
/// running it on the same Wi-Fi. Switching signs out and restarts the app.
Future<void> showServerSettings(BuildContext context) async {
  final fallback = await serverUrl;
  if (!context.mounted) return;
  final input = TextEditingController(text: activeServerUrl);
  String? error;
  final choice = await showDialog<String>(
    context: context,
    builder: (c) => StatefulBuilder(
      builder: (c, set) => AlertDialog(
        title: const Text('Server address'),
        content: SizedBox(
          width: 420,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'GymOS connects to the GymOS server. At home that is the computer running it — keep this phone on the same Wi-Fi.',
                style: TextStyle(color: GymTheme.muted, height: 1.5),
              ),
              const SizedBox(height: 18),
              TextField(
                controller: input,
                keyboardType: TextInputType.url,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: 'Server address',
                  hintText: '192.168.0.10:8080',
                  prefixIcon: const Icon(Icons.dns_outlined),
                  errorText: error,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Built-in: $fallback',
                style: const TextStyle(color: GymTheme.subtle, fontSize: 12),
              ),
              const SizedBox(height: 6),
              const Text(
                'Changing the server signs you out on this phone.',
                style: TextStyle(color: GymTheme.subtle, fontSize: 12),
              ),
            ],
          ),
        ),
        actions: [
          if (activeServerUrl != fallback)
            TextButton(
              onPressed: () => Navigator.pop(c, fallback),
              child: const Text('Use built-in'),
            ),
          TextButton(
            onPressed: () => Navigator.pop(c),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final url = normalizeServerUrl(input.text);
              if (url == null) {
                set(() => error = 'Enter an address like 192.168.0.10:8080');
                return;
              }
              Navigator.pop(c, url);
            },
            child: const Text('Connect'),
          ),
        ],
      ),
    ),
  );
  input.dispose();
  if (choice == null || choice == activeServerUrl) return;
  await switchServer(choice == fallback ? null : choice);
}

/// Shows the current server with a change action; phones only.
class ServerAddressRow extends StatelessWidget {
  const ServerAddressRow({super.key});
  @override
  Widget build(BuildContext context) {
    if (!serverAddressEditable) return const SizedBox.shrink();
    return Row(
      children: [
        const Icon(Icons.dns_outlined, size: 16, color: GymTheme.subtle),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'Server: ${Uri.tryParse(activeServerUrl)?.authority ?? activeServerUrl}',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: GymTheme.muted, fontSize: 12.5),
          ),
        ),
        TextButton(
          onPressed: () => showServerSettings(context),
          child: const Text('Change'),
        ),
      ],
    );
  }
}
