import 'package:flutter/material.dart';

import '../../../utilities/config.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownMenu(
              dropdownMenuEntries: const [
                DropdownMenuEntry(value: 90000, label: '90kbps'),
                DropdownMenuEntry(value: 128000, label: '128kbps'),
                DropdownMenuEntry(value: 192000, label: '192kbps'),
                DropdownMenuEntry(value: 320000, label: '320kbps'),
              ],
              leadingIcon: const Icon(Icons.music_note),
              label: const Text('Bitrate'),
              onSelected: (int? value) {
                if (value != null) {
                  Config.audioBitrate = value;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
