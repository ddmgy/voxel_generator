import 'package:voxel_generator/shape/base.dart';

class Cuboid extends Shape3d {
  double get top => -halfHeight;
  double get bottom => halfHeight;
  double get left => -halfWidth;
  double get right => halfWidth;
  double get front => -halfDepth;
  double get back => halfDepth;

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
  bool contains(num x, num y, num z) => x >= left
   && x <= right
   && z >= top
   && z <= bottom
   && y >= front
   && y <= back;
}
