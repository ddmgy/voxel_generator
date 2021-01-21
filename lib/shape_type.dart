import 'package:voxel_generator/utils.dart';

enum ShapeType {
  Capsule,
  Circle,
  Cube,
  Cuboid,
  Cylinder,
  Ellipse,
  Ellipsoid,
  Rectangle,
  Sphere,
  Square,
  Stadium,
}

extension ShapeTypeExtensions on ShapeType {
  String getName() => toString().substringAfterLast('.');

  int toInt() => index;
}

extension IntToShapeTypeExtensions on int {
  ShapeType toShapeType() => ShapeType.values[this % ShapeType.values.length];
}
