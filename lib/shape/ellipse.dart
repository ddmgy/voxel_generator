import 'dart:math' as Math;

import 'package:voxel_generator/shape/base.dart';

class Ellipse extends Shape3d {
  double get a => halfWidth;
  double get b => halfDepth;

  Ellipse({
    int width,
    int height,
  }) : super(
    width: width,
    depth: height,
    height: 1,
  );

  @override
  bool contains(num x, num y, num z) {
    return (Math.pow(x, 2) / Math.pow(a, 2))
      + (Math.pow(y, 2) / Math.pow(b, 2)) <= 1;
  }
}
