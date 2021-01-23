import 'package:voxel_generator/shape/base.dart';
import 'package:voxel_generator/shape/shape_utils.dart';

class Triangle extends Shape3d {
  Point2d _top;
  Point2d _bottomRight;
  Point2d _bottomLeft;

  Triangle({
    int width,
    int height,
  }) : super(
    width: width,
    depth: height,
    height: 1,
  );

  bool contains(num x, num y, num z) {
    if (_top == null) {
      _top = Point2d(0, -halfDepth);
      _bottomRight = Point2d(halfWidth, halfDepth);
      _bottomLeft = Point2d(-halfWidth, halfDepth);
    }
    return ShapeUtils.pointInTriangle(x, y, _top, _bottomRight, _bottomLeft);
  }
}
