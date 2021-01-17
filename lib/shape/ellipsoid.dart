import 'dart:math' as Math;

import 'package:voxel_generator/shape/base.dart';

class Ellipsoid extends Shape3d {
  double get a => halfWidth;
  double get b => halfDepth;
  double get c => halfHeight;

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
  bool contains(num x, num y, num z) {
    final dx = x;
    final dy = y;
    final dz = z;
    return (Math.pow(dx, 2) / Math.pow(a, 2))
      + (Math.pow(dy, 2) / Math.pow(b, 2))
      + (Math.pow(dz, 2) / Math.pow(c, 2)) <= 1;
  }
}
