import 'package:voxel_generator/shape/base.dart';
import 'package:voxel_generator/shape/shape_utils.dart';

class Capsule extends Shape3d {
  final int sideLength;

  Capsule({
    this.sideLength,
    int diameter,
  }) : super(
    width: sideLength + diameter,
    depth: diameter,
    height: diameter,
  );

  @override
  bool contains(num x, num y, num z) => ShapeUtils.pointInCapsule(x, y, z, sideLength, depth);
}
