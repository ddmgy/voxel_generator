import 'package:flutter/material.dart';

import 'package:preferences_ui/preferences_ui.dart';
import 'package:provider/provider.dart';

import 'package:voxel_generator/preference/preferences_helper.dart';
import 'package:voxel_generator/preference/preferences_provider.dart';
import 'package:voxel_generator/ui/theme_type.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<PreferencesProvider>(
    builder: (context, provider, _) => PreferenceScreen(
      title: 'Settings',
      children: [
        PreferenceGroup(
          title: 'General',
          children: [
            ListPreference<ThemeType>(
              title: 'Application theme',
              dialogTitle: 'Choose theme',
              value: provider.themeType,
              entries: PreferenceEntries.themes,
              entryValues: PreferenceValues.themes,
              onChanged: (ThemeType newThemeType) {
                provider.themeType = newThemeType;
              },
            ),
          ],
        ),
        PreferenceGroup(
          title: 'Advanced',
          children: [
            Preference(
              title: 'Reset user preferences',
              leading: Icon(Icons.code),
              onLongPress: () {
                provider.clearPreferences();
                print('why you no work?');
              },
            ),
          ],
        ),
        PreferenceGroup(
          title: 'About',
          children: [
            Preference(
              title: 'Version',
              summary: '0.1.3',
              onTap: () {},
            ),
            Preference(
              title: 'Licenses',
              onTap: () => showLicensePage(
                context: context,
                applicationName: 'Voxel Generator',
                applicationVersion: '0.1.1',
                applicationLegalese: '© 2021 David Mougey',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
