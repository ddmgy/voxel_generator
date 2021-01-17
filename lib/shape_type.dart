import 'package:voxel_generator/utils.dart';

enum ShapeType {
  Circle,
  Cube,
  Cuboid,
  Cylinder,
  Ellipse,
  Ellipsoid,
  Rectangle,
  Sphere,
  Square,
}

extension ShapeTypeExtensions on ShapeType {
  String getName() => toString().substringAfterLast('.');

  int toInt() => index;
}

extension IntToShapeTypeExtensions on int {
  ShapeType toShapeType() => ShapeType.values[this % ShapeType.values.length];
}