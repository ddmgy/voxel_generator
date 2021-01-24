import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import 'package:voxel_generator/preference/preferences_provider.dart';
import 'package:voxel_generator/ui/main/filter_fit_button.dart';
import 'package:voxel_generator/ui/main/property_button.dart';
import 'package:voxel_generator/ui/main/viewer_type_button.dart';
import 'package:voxel_generator/ui/option_tile_type.dart';
import 'package:voxel_generator/ui/shape_type.dart';
import 'package:voxel_generator/ui/viewer_type.dart';
import 'package:voxel_generator/utils.dart';

typedef ColorPreferenceSetter = Function(Color newColor);

class PropertiesPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<PreferencesProvider>(
    builder: (context, prefs, _) {
      final shapeType = prefs.selectedShapeType;
      final children = <Widget>[];

      final viewerOptions = <Widget>[
        ViewerTypeButton(),
        if (prefs.viewerType == ViewerType.Voxel) FilterFitButton(),
      ];

      final viewerOptionsTile = ExpansionTile(
        leading: Icon(
          Icons.view_in_ar,
          color: context.iconColor(),
        ),
        title: Text(
          'Viewer',
        ),
        children: viewerOptions,
        initiallyExpanded: prefs.getTileExpanded(OptionTileType.viewerOptions),
        onExpansionChanged: (bool expanded) {
          prefs.setTileExpanded(OptionTileType.viewerOptions, expanded);
        },
      );
      children.add(viewerOptionsTile);

      final properties = <Widget>[];
      if (shapeType == ShapeType.Capsule) {
        properties.add(PropertySideLengthButton(shapeType: shapeType));
        properties.add(PropertyDiameterButton(shapeType: shapeType));
      } else if (shapeType == ShapeType.Circle) {
        properties.add(PropertyDiameterButton(shapeType: shapeType));
      } else if (shapeType == ShapeType.Cube) {
        properties.add(PropertySideLengthButton(shapeType: shapeType));
      } else if (shapeType == ShapeType.Cuboid) {
        properties.add(PropertyWidthButton(shapeType: shapeType));
        properties.add(PropertyDepthButton(shapeType: shapeType));
        properties.add(PropertyHeightButton(shapeType: shapeType));
      } else if (shapeType == ShapeType.Cylinder) {
        properties.add(PropertyWidthButton(shapeType: shapeType));
        properties.add(PropertyDepthButton(shapeType: shapeType));
        properties.add(PropertyHeightButton(shapeType: shapeType));
      } else if (shapeType == ShapeType.Ellipse) {
        properties.add(PropertyWidthButton(shapeType: shapeType));
        properties.add(PropertyHeightButton(shapeType: shapeType));
      } else if (shapeType == ShapeType.Ellipsoid) {
        properties.add(PropertyWidthButton(shapeType: shapeType));
        properties.add(PropertyDepthButton(shapeType: shapeType));
        properties.add(PropertyHeightButton(shapeType: shapeType));
      } else if (shapeType == ShapeType.Pyramid) {
        properties.add(PropertyWidthButton(shapeType: shapeType));
        properties.add(PropertyDepthButton(shapeType: shapeType));
        properties.add(PropertyHeightButton(shapeType: shapeType));
      } else if (shapeType == ShapeType.Rectangle) {
        properties.add(PropertyWidthButton(shapeType: shapeType));
        properties.add(PropertyHeightButton(shapeType: shapeType));
      } else if (shapeType == ShapeType.Sphere) {
        properties.add(PropertyDiameterButton(shapeType: shapeType));
      } else if (shapeType == ShapeType.Square) {
        properties.add(PropertySideLengthButton(shapeType: shapeType));
      } else if (shapeType == ShapeType.Stadium) {
        properties.add(PropertySideLengthButton(shapeType: shapeType));
        properties.add(PropertyDiameterButton(shapeType: shapeType));
      } else if (shapeType == ShapeType.Triangle) {
        properties.add(PropertyWidthButton(shapeType: shapeType));
        properties.add(PropertyHeightButton(shapeType: shapeType));
      } else if (shapeType == ShapeType.Triangle_right) {
        properties.add(PropertyWidthButton(shapeType: shapeType));
        properties.add(PropertyHeightButton(shapeType: shapeType));
      }
      final propertiesTile = ExpansionTile(
        leading: Icon(
          Icons.edit,
          color: context.iconColor(),
        ),
        title: Text(
          'Properties',
          style: context.titleTextStyle(),
        ),
        children: properties,
        initiallyExpanded: prefs.getTileExpanded(OptionTileType.properties),
        onExpansionChanged: (bool expanded) {
          prefs.setTileExpanded(OptionTileType.properties, expanded);
        },
      );
      children.add(propertiesTile);

      final colorPreferences = <Widget>[];
      colorPreferences.add(ListTile(
        trailing: _colorIcon(prefs.rightFaceColor),
        title: Text(
          'Right face',
          style: context.titleTextStyle(),
        ),
        onTap: () => _showColorPickerDialog(
          context,
          prefs.rightFaceColor,
              (Color newColor) => prefs.rightFaceColor = newColor,
        ),
      ));
      colorPreferences.add(ListTile(
        trailing: _colorIcon(prefs.leftFaceColor),
        title: Text(
          'Left face',
          style: context.titleTextStyle(),
        ),
        onTap: () => _showColorPickerDialog(
          context,
          prefs.leftFaceColor,
              (Color newColor) => prefs.leftFaceColor = newColor,
        ),
      ));
      colorPreferences.add(ListTile(
        trailing: _colorIcon(prefs.topFaceColor),
        title: Text(
          'Top face',
          style: context.titleTextStyle(),
        ),
        onTap: () => _showColorPickerDialog(
          context,
          prefs.topFaceColor,
              (Color newColor) => prefs.topFaceColor = newColor,
        ),
      ));
      colorPreferences.add(ListTile(
        trailing: _colorIcon(prefs.outlineColor),
        title: Text(
          'Outline',
          style: context.titleTextStyle(),
        ),
        onTap: () => _showColorPickerDialog(
          context,
          prefs.outlineColor,
              (Color newColor) => prefs.outlineColor = newColor,
        ),
      ));
      colorPreferences.add(ListTile(
        trailing: Checkbox(
          value: prefs.onlyUseRightFaceColor,
          onChanged: (bool newValue) => prefs.onlyUseRightFaceColor = newValue,
        ),
        title: Text(
          'Only use right face',
          style: context.titleTextStyle(),
        ),
        onTap: () => prefs.onlyUseRightFaceColor = !prefs.onlyUseRightFaceColor,
      ));

      final colorPreferencesTile = ExpansionTile(
        leading: Icon(
          Icons.color_lens,
          color: context.iconColor(),
        ),
        title: Text(
          'Colors',
          style: context.titleTextStyle(),
        ),
        children: colorPreferences,
        initiallyExpanded: prefs.getTileExpanded(OptionTileType.colors),
        onExpansionChanged: (bool expanded) {
          prefs.setTileExpanded(OptionTileType.colors, expanded);
        },
      );
      children.add(colorPreferencesTile);

      return ListView(
        shrinkWrap: true,
        children: children,
      );
    },
  );

  Widget _colorIcon(Color color) => AnimatedContainer(
    color: color,
    height: 24,
    width: 24,
    duration: kThemeChangeDuration,
  );

  void _showColorPickerDialog(
    BuildContext context,
    Color initialColor,
    ColorPreferenceSetter onColorChanged,
  ) async {
    final result = await showDialog<Color>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Choose a color',
          style: context.titleTextStyle(),
        ),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: initialColor,
            showLabel: true,
            onColorChanged: (Color color) => initialColor = color,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              'Cancel',
              style: context.subtitleTextStyle(),
            ),
            onPressed: () => Navigator.of(context).pop(null),
          ),
          TextButton(
            child: Text(
              'OK',
              style: context.subtitleTextStyle(),
            ),
            onPressed: () => Navigator.of(context).pop(initialColor),
          ),
        ],
      ),
    );

    if (result != null) {
      onColorChanged(result);
    }
  }
}
