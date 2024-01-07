import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ui/screens/about/about_screen.dart';
import 'ui/screens/home/home_screen.dart';
import 'ui/screens/settings/settings_screen.dart';
import 'utilities/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: SimpleRadio(),
    ),
  );
}

class SimpleRadio extends StatelessWidget {
  const SimpleRadio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Radio',
      theme: appTheme,
      home: HomeScreen(),
      routes: Map<String, WidgetBuilder>.from(
        {
          'settings': (context) => const SettingsScreen(),
          'about': (context) => const AboutScreen(),
        },
      ),
    );
  }
}
