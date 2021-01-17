import 'dart:math' as Math;

import 'package:voxel_generator/shape/base.dart';

class Cylinder extends Shape3d {
  double get top => -halfHeight;
  double get bottom => halfHeight;
  double get a => halfWidth;
  double get b => halfDepth;

  Cylinder({
    int diameter,
    int height,
  }) : super(
    width: diameter,
    depth: diameter,
    height: height,
  );

  @override
  bool contains(num x, num y, num z) {
    if (z > bottom || z < top) {
      return false;
    }
    return (Math.pow(x, 2) / Math.pow(a, 2))
      + (Math.pow(y, 2) / Math.pow(b, 2)) <= 1;
  }
}
