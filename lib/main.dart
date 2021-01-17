import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:voxel_generator/preference/preferences_provider.dart';
import 'package:voxel_generator/ui/home_screen.dart';
import 'package:voxel_generator/ui/routes.dart';
import 'package:voxel_generator/ui/settings_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider<PreferencesProvider>(
      create: (context) => PreferencesProvider(),
      builder: (context, child) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.select((PreferencesProvider provider) => provider.theme);
    return MaterialApp(
      title: 'Voxel Generator',
      theme: theme,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case Routes.home:
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => HomeScreen(),
            );
          case Routes.settings:
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => SettingsScreen(),
            );
        }
        throw Exception('Unknown route name: ${settings.name}');
      },
    );
  }
}