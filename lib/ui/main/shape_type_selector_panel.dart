import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:voxel_generator/preference/preferences_provider.dart';
import 'package:voxel_generator/ui/shape_type.dart';
import 'package:voxel_generator/utils.dart';

class ShapeTypeSelectorPanel extends StatelessWidget {
  final VoidCallback onSelectedChanged;

  ShapeTypeSelectorPanel({
    Key key,
    this.onSelectedChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<PreferencesProvider>(
    builder: (context, prefs, _) {
      final selectedShapeType = prefs.selectedShapeType;
      final children = <Widget>[];

      for (final shapeType in ShapeType.values) {
        final tile = ListTile(
          title: Text(
            shapeType.getName(),
            style: context.titleTextStyle(),
          ),
          dense: true,
          selected: shapeType == selectedShapeType,
          onTap: () {
            if (shapeType == selectedShapeType) {
              return;
            }
            prefs.selectedShapeType = shapeType;
            if (onSelectedChanged != null) {
              onSelectedChanged();
            }
          },
        );
        children.add(tile);
      }

      return ListView(
        shrinkWrap: true,
        children: children,
      );
    },
  );
}
