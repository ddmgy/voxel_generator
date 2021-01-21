import 'package:voxel_generator/shape/base.dart';
import 'package:voxel_generator/shape/shape_utils.dart';

class Cuboid extends Shape3d {
  Cuboid({
    int width,
    int depth,
    int height,
  }) : super(
    width: width,
    depth: depth,
    height: height,
  );

  @override
  bool contains(num x, num y, num z) => ShapeUtils.pointInCuboid(x, y, z, width, depth, height);
}
