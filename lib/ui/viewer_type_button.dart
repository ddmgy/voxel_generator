import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:voxel_generator/preference/preferences_provider.dart';
import 'package:voxel_generator/utils.dart';
import 'package:voxel_generator/viewer_type.dart';

class ViewerTypeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewerType = context.select((PreferencesProvider provider) => provider.viewerType);

    return ListTile(
      leading: Icon(
        Icons.view_in_ar,
        color: context.iconColor(),
      ),
      title: Text(
        "Viewer type",
        style: context.titleTextStyle(),
      ),
      trailing: DropdownButton<ViewerType>(
        value: viewerType,
        onChanged: (ViewerType viewerType) => Provider.of<PreferencesProvider>(context, listen: false).viewerType = viewerType,
        items: ViewerType.values.map((vt) => DropdownMenuItem<ViewerType>(
          value: vt,
          child: Text(
            vt.getName(),
            style: context.subtitleTextStyle(),
          ),
        )).toList(),
        selectedItemBuilder: (context) => ViewerType.values.map((vt) => Align(
          alignment: Alignment.center,
          child: Text(
            vt.getName(),
            style: context.subtitleTextStyle(),
          ),
        )).toList(),
      ),
      dense: true,
    );
  }
}
