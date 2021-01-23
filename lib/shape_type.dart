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
  Triangle,
  Triangle_right,
}

extension ShapeTypeExtensions on ShapeType {
  String getName() {
    final name = toString().substringAfterLast('.');
    if (!name.contains('_')) {
      return name;
    }
    final split = name.split('_').toList();
    return '${split.first} (${split.skip(1).join(' ')})';
  }

  int toInt() => index;
}

extension IntToShapeTypeExtensions on int {
  ShapeType toShapeType() => ShapeType.values[this % ShapeType.values.length];
}
