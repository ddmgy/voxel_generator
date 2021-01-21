import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:voxel_generator/preference/preferences_helper.dart';
import 'package:voxel_generator/preference/preferences_provider.dart';
import 'package:voxel_generator/utils.dart';

class FilterFitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fit = context.select((PreferencesProvider provider) => provider.fit);

    return ListTile(
      title: Text(
        "Fit",
        style: context.titleTextStyle(),
      ),
      trailing: DropdownButton<BoxFit>(
        value: fit,
        onChanged: (BoxFit value) => Provider.of<PreferencesProvider>(context, listen: false).fit = value,
        items: PreferenceValues.fits.map((boxFit) => DropdownMenuItem<BoxFit>(
          value: boxFit,
          child: Text(
            boxFit.getName(),
            style: context.subtitleTextStyle(),
          ),
        )).toList(),
        selectedItemBuilder: (context) => PreferenceValues.fits.map((boxFit) => Align(
          alignment: Alignment.center,
          child: Text(
            boxFit.getName(),
            style: context.subtitleTextStyle(),
          ),
        )).toList(),
      ),
      dense: true,
    );
  }
}
