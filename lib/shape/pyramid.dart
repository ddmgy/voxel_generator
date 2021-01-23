import 'package:voxel_generator/shape/base.dart';
import 'package:voxel_generator/shape/shape_utils.dart';

class Pyramid extends Shape3d {
  List<Plane> _planes;

  Pyramid({
    int width,
    int depth,
    int height,
  }) : super(
    width: width,
    depth: depth,
    height: height,
  );

  @override
  bool contains(num x, num y, num z) {
    if (_planes == null) {
      final top = Point3d(0, 0, -halfHeight);
      final topLeft = Point3d(-halfWidth, -halfDepth, halfHeight);
      final topRight = Point3d(halfWidth, -halfDepth, halfHeight);
      final bottomRight = Point3d(halfWidth, halfDepth, halfHeight);
      final bottomLeft = Point3d(-halfWidth, halfDepth, halfHeight);
      _planes = [
        Plane.fromPoints(top, topLeft, topRight),
        Plane.fromPoints(top, topRight, bottomRight),
        Plane.fromPoints(top, bottomRight, bottomLeft),
        Plane.fromPoints(top, bottomLeft, topLeft),
      ];
    }
    return ShapeUtils.pointBetweenPlanes(x, y, z, _planes);
  }
}
