import 'dart:math' as Math;

import 'package:voxel_generator/shape/base.dart';
import 'package:voxel_generator/utils.dart';

/// Utility class to test if point lies inside of shapes.
/// All shapes are assumed to be centered at the 2D origin (0, 0) or 3D origin (0, 0, 0).
class ShapeUtils {
  /// Checks is point at (x, y) lies in ellipse defined by axes a and b.
  static bool pointInEllipse(num x, num y, num a, num b) =>
    (Math.pow(x, 2) / Math.pow(a, 2)) + (Math.pow(y, 2) / Math.pow(b, 2)) <= 1;

  /// Checks if point at (x, y) lies in circle defined by diameter.
  static bool pointInCircle(num x, num y, num diameter) =>
    pointInEllipse(x, y, diameter / 2, diameter / 2);

  /// Checks if point at (x, y) lies in rectangle defined by width and height.
  static bool pointInRectangle(num x, num y, num width, num height) {
    final hw = width / 2;
    final hh = height / 2;
    return x >= -hw && x <= hw && y >= -hh && y <= hh;
  }

  /// Checks if point at (x, y) lies in square defined by side length.
  static bool pointInSquare(num x, num y, num sideLength) =>
    pointInRectangle(x, y, sideLength, sideLength);

  /// Checks if point at (x, y, z) lies in cuboid defined by width, depth, and height.
  static bool pointInCuboid(num x, num y, num z, num width, num depth, num height) {
    final hw = width / 2;
    final hd = depth / 2;
    final hh = height / 2;
    return x >= -hw
      && x <= hw
      && y >= -hd
      && y <= hd
      && z >= -hh
      && z <= hh;
  }

  /// Checks if point at (x, y, z) lies in cube defined by side length.
  static bool pointInCube(num x, num y, num z, num sideLength) =>
    pointInCuboid(x, y, z, sideLength, sideLength, sideLength);

  /// Checks if point at (x, y, z) lies in cylinder defined by axes a and b, and height.
  static bool pointInCylinder(num x, num y, num z, num a, num b, num height) {
    final hh = height / 2;
    if (z > hh || z < -hh) {
      return false;
    }
    return pointInEllipse(x, y, a, b);
  }

  /// Checks if point at (x, y, z) lies in ellipsoid defined by axes a, b, and c.
  static bool pointInEllipsoid(num x, num y, num z, num a, num b, num c) =>
    (Math.pow(x, 2) / Math.pow(a, 2)) + (Math.pow(y, 2) / Math.pow(b, 2)) + (Math.pow(z, 2) / Math.pow(c, 2)) <= 1;

  /// Checks if point at (x, y, z) lies in sphere defined by diameter.
  static bool pointInSphere(num x, num y, num z, num diameter) {
    final radius = diameter / 2;
    return pointInEllipsoid(x, y, z, radius, radius, radius);
  }

  /// Checks if point at (x, y) lies in stadium defined by side length and diameter.
  static bool pointInStadium(num x, num y, num sideLength, num diameter) => (
  ShapeUtils.pointInRectangle(x, y, sideLength, diameter) ||
  ShapeUtils.pointInCircle(x - sideLength / 2, y, diameter) ||
  ShapeUtils.pointInCircle(x + sideLength / 2, y, diameter)
  );

  /// Checks if point at (x, y, z) lies in capsule defined by side length and diameter.
  static bool pointInCapsule(num x, num y, num z, num sideLength, num diameter) {
    final halfSideLength = sideLength / 2;
    if (x > -halfSideLength && x < halfSideLength) {
      return pointInCircle(y, z, diameter);
    }
    return pointInSphere(x - halfSideLength, y, z, diameter) ||
      pointInSphere(x + halfSideLength, y, z, diameter);
  }

  /// Checks if point at (x, y) is in triangle defined by points p1, p2, and p3.
  static bool pointInTriangle(num x, num y, Point2d p1, Point2d p2, Point2d p3) {
    final p = Point2d(x, y);
    final signs = [
      p.sign(p1, p2),
      p.sign(p2, p3),
      p.sign(p3, p1),
    ];
    final hasNegative = signs.any((s) => s < 0);
    final hasPositive = signs.any((s) => s > 0);
    return !(hasNegative && hasPositive);
  }

  /// Checks if point at (x, y, z) lies between all given planes.
  static bool pointBetweenPlanes(num x, num y, num z, List<Plane> planes) {
    final point = Point3d(x, y, z);
    return planes
      .map((p) => p.distanceFromPoint(point))
      .all((d) => d > 0);
  }
}
