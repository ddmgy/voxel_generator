import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:voxel_generator/preference/preferences_provider.dart';
import 'package:voxel_generator/shape/shape.dart';
import 'package:voxel_generator/ui/shape_properties.dart';
import 'package:voxel_generator/ui/shape_type.dart';

class ShapeMapper {
  static Shape3d mapToShape(BuildContext context, ShapeType shapeType) {
    final prefs = Provider.of<PreferencesProvider>(context, listen: false);

    if (shapeType == ShapeType.Capsule) {
      return Capsule(
        sideLength: prefs.getShapeProperty(shapeType, ShapeProperties.sideLength, 8),
        diameter: prefs.getShapeProperty(shapeType, ShapeProperties.diameter, 8),
      );
    } else if (shapeType == ShapeType.Circle) {
      return Circle(
        diameter: prefs.getShapeProperty(shapeType, ShapeProperties.diameter, 8),
      );
    } else if (shapeType == ShapeType.Cube) {
      return Cube(
        sideLength: prefs.getShapeProperty(shapeType, ShapeProperties.sideLength, 8),
      );
    } else if (shapeType == ShapeType.Cuboid) {
      return Cuboid(
        width: prefs.getShapeProperty(shapeType, ShapeProperties.width, 8),
        depth: prefs.getShapeProperty(shapeType, ShapeProperties.depth, 8),
        height: prefs.getShapeProperty(shapeType, ShapeProperties.height, 8),
      );
    } else if (shapeType == ShapeType.Cylinder) {
      return Cylinder(
        width: prefs.getShapeProperty(shapeType, ShapeProperties.width, 8),
        depth: prefs.getShapeProperty(shapeType, ShapeProperties.depth, 8),
        height: prefs.getShapeProperty(shapeType, ShapeProperties.height, 8),
      );
    } else if (shapeType == ShapeType.Ellipse) {
      return Ellipse(
        width: prefs.getShapeProperty(shapeType, ShapeProperties.width, 8),
        height: prefs.getShapeProperty(shapeType, ShapeProperties.height, 8),
      );
    } else if (shapeType == ShapeType.Ellipsoid) {
      return Ellipsoid(
        width: prefs.getShapeProperty(shapeType, ShapeProperties.width, 8),
        depth: prefs.getShapeProperty(shapeType, ShapeProperties.depth, 8),
        height: prefs.getShapeProperty(shapeType, ShapeProperties.height, 8),
      );
    } else if (shapeType == ShapeType.Pyramid) {
      return Pyramid(
        width: prefs.getShapeProperty(shapeType, ShapeProperties.width, 8),
        depth: prefs.getShapeProperty(shapeType, ShapeProperties.depth, 8),
        height: prefs.getShapeProperty(shapeType, ShapeProperties.height, 8),
      );
    } else if (shapeType == ShapeType.Rectangle) {
      return Rectangle(
        width: prefs.getShapeProperty(shapeType, ShapeProperties.width, 8),
        height: prefs.getShapeProperty(shapeType, ShapeProperties.height, 8),
      );
    } else if (shapeType == ShapeType.Sphere) {
      return Sphere(
        diameter: prefs.getShapeProperty(shapeType, ShapeProperties.diameter, 8),
      );
    } else if (shapeType == ShapeType.Square) {
      return Square(
        sideLength: prefs.getShapeProperty(shapeType, ShapeProperties.sideLength, 8),
      );
    } else if (shapeType == ShapeType.Stadium) {
      return Stadium(
        sideLength: prefs.getShapeProperty(shapeType, ShapeProperties.sideLength, 8),
        diameter: prefs.getShapeProperty(shapeType, ShapeProperties.diameter, 8),
      );
    } else if (shapeType == ShapeType.Triangle) {
      return Triangle(
        width: prefs.getShapeProperty(shapeType, ShapeProperties.width, 8),
        height: prefs.getShapeProperty(shapeType, ShapeProperties.height, 8),
      );
    } else if (shapeType == ShapeType.Triangle_right) {
      return TriangleRight(
        width: prefs.getShapeProperty(shapeType, ShapeProperties.width, 8),
        height: prefs.getShapeProperty(shapeType, ShapeProperties.height, 8),
      );
    }
    throw Exception('unreachable');
  }
}
