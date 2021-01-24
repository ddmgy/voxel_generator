import 'dart:math' as Math;

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:voxel_generator/preference/preferences_provider.dart';
import 'package:voxel_generator/ui/shape_properties.dart';
import 'package:voxel_generator/ui/shape_type.dart';
import 'package:voxel_generator/utils.dart';

class PropertyButton extends StatelessWidget {
  final ShapeType shapeType;
  final String title;
  final String property;
  final int defaultValue;
  final int min;
  final int max;

  PropertyButton({
    Key key,
    @required this.shapeType,
    @required this.title,
    @required this.property,
    @required this.defaultValue,
    this.min = 1,
    this.max = 100,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) => Consumer<PreferencesProvider>(
    builder: (context, prefs, _) {
      final value = prefs.getShapeProperty(shapeType, property, defaultValue);

      return ListTile(
        title: Text(
          title,
          style: context.titleTextStyle(),
        ),
        trailing: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () {
                final newValue = Math.max(min, value - 1);
                if (newValue != value) {
                  prefs.setShapeProperty(shapeType, property, newValue);
                }
              },
            ),
            Text(
              value.toString(),
              style: context.subtitleTextStyle(),
            ),
            IconButton(
              icon: Icon(Icons.chevron_right),
              onPressed: () {
                final newValue = Math.min(max, value + 1);
                if (newValue != value) {
                  prefs.setShapeProperty(shapeType, property, newValue);
                }
              },
            ),
          ],
        ),
      );
    },
  );
}

class PropertyWidthButton extends PropertyButton {
  PropertyWidthButton({
    Key key,
    @required ShapeType shapeType,
  }) : super(
    key: key,
    shapeType: shapeType,
    title: 'Width',
    property: ShapeProperties.width,
    defaultValue: 8,
    min: 1,
    max: 128,
  );
}

class PropertyDepthButton extends PropertyButton {
  PropertyDepthButton({
    Key key,
    @required ShapeType shapeType,
  }) : super(
    key: key,
    shapeType: shapeType,
    title: 'Depth',
    property: ShapeProperties.depth,
    defaultValue: 8,
    min: 1,
    max: 128,
  );
}

class PropertyHeightButton extends PropertyButton {
  PropertyHeightButton({
    Key key,
    @required ShapeType shapeType,
  }) : super(
    key: key,
    shapeType: shapeType,
    title: 'Height',
    property: ShapeProperties.height,
    defaultValue: 8,
    min: 1,
    max: 128,
  );
}

class PropertyDiameterButton extends PropertyButton {
  PropertyDiameterButton({
    Key key,
    @required ShapeType shapeType,
  }) : super(
    key: key,
    shapeType: shapeType,
    title: 'Diameter',
    property: ShapeProperties.diameter,
    defaultValue: 8,
    min: 1,
    max: 128,
  );
}

class PropertySideLengthButton extends PropertyButton {
  PropertySideLengthButton({
    Key key,
    @required ShapeType shapeType,
  }) : super(
    key: key,
    shapeType: shapeType,
    title: 'Side length',
    property: ShapeProperties.sideLength,
    defaultValue: 8,
    min: 1,
    max: 128,
  );
}
