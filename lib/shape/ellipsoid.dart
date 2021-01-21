import 'package:voxel_generator/shape/base.dart';
import 'package:voxel_generator/shape/shape_utils.dart';

class Ellipsoid extends Shape3d {
  Ellipsoid({
    int width,
    int depth,
    int height,
  }) : super(
    width: width,
    depth: depth,
    height: height,
  );

  @override
  bool contains(num x, num y, num z) =>
    ShapeUtils.pointInEllipsoid(x, y, z, halfWidth, halfDepth, halfHeight);
}
