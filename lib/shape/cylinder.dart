import 'package:voxel_generator/shape/base.dart';
import 'package:voxel_generator/shape/shape_utils.dart';

class Cylinder extends Shape3d {
  Cylinder({
    int width,
    int depth,
    int height,
  }) : super(
    width: width,
    depth: depth,
    height: height,
  );

  @override
  bool contains(num x, num y, num z) => ShapeUtils.pointInCylinder(x, y, z, halfWidth, halfDepth, height);
}
