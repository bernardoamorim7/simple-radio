import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ui/screens/about/about_screen.dart';
import 'ui/screens/home/home_screen.dart';
import 'ui/screens/settings/settings_screen.dart';
import 'utilities/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: SimpleRadio(),
    ),
  );
}

class SimpleRadio extends ConsumerWidget {
  const SimpleRadio({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeProvider);

    return MaterialApp(
      title: 'Simple Radio',
      theme: appThemeState.isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: appThemeState.isDark ? ThemeMode.dark : ThemeMode.light,
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
