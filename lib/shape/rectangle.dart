import 'package:voxel_generator/shape/base.dart';
import 'package:voxel_generator/shape/shape_utils.dart';

class Rectangle extends Shape3d {
  Rectangle({
    int width,
    int height,
  }) : super(
    width: width,
    depth: height,
    height: 1,
  );

  @override
  bool contains(num x, num y, num z) => ShapeUtils.pointInRectangle(x, y, width, depth);
}
