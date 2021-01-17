import 'package:voxel_generator/shape/base.dart';

class Rectangle extends Shape3d {
  double get top => -halfDepth;
  double get bottom => halfDepth;
  double get left => -halfWidth;
  double get right => halfWidth;

  Rectangle({
    int width,
    int height,
  }) : super(
    width: width,
    depth: height,
    height: 1,
  );

  @override
  bool contains(num x, num y, num z) => x >= left
    && x <= right
    && y >= top
    && y <= bottom;
}
