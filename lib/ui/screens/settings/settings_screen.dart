import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utilities/app_theme.dart';
import '../../../utilities/config.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeProvider);
    final configState = ref.watch(configProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Audio Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: Text(
                'Bitrate',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              trailing: DropdownButton<int>(
                focusColor: Theme.of(context).colorScheme.primary,
                dropdownColor: Theme.of(context).colorScheme.inversePrimary,
                value: configState.audioBitrate,
                items: [
                  DropdownMenuItem<int>(
                    value: 32000,
                    child: Text(
                      '32 kbps',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  DropdownMenuItem<int>(
                    value: 64000,
                    child: Text(
                      '64 kbps',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  DropdownMenuItem<int>(
                    value: 128000,
                    child: Text(
                      '128 kbps',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  DropdownMenuItem<int>(
                    value: 256000,
                    child: Text(
                      '256 kbps',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  DropdownMenuItem<int>(
                    value: 320000,
                    child: Text(
                      '320 kbps',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
                onChanged: (int? value) async {
                  if (value != null) {
                    configState.audioBitrate = value;
                    await configState.setAudioBitrate(value);
                  }
                },
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Display Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: Text(
                'Dark Mode',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.primary,
              value: appThemeState.isDark,
              onChanged: (bool value) async {
                appThemeState.toggle();
                await appThemeState.setTheme(value: value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
