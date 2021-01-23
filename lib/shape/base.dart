import 'dart:math' as Math;

class Point2d {
  final num x;
  final num y;

  const Point2d(this.x, this.y);

  double sign(Point2d v1, Point2d v2) => (x - v2.x) * (v1.y - v2.y) - (v1.x - v2.x) * (y - v2.y);

  @override
  String toString() => '($x, $y)';
}

class Point3d extends Point2d {
  final num z;

  const Point3d(num x, num y, this.z) : super(x, y);

  num dot(Point3d other) => x * other.x + y * other.y + z * other.z;

  Point3d cross(Point3d other) => Point3d(
    y * other.z - z * other.y,
    z * other.x - x * other.z,
    x * other.y - y * other.x,
  );

  Point3d operator -(Point3d other) => Point3d(
    x - other.x,
    y - other.y,
    z - other.z,
  );

  num magnitude() => Math.sqrt(x * x + y * y + z * z);

  Point3d normalize() {
    final m = magnitude();
    return Point3d(
      x / m,
      y / m,
      z / m,
    );
  }

  @override
  String toString() => '($x, $y, $z)';
}

class Plane {
  final Point3d normal;
  final double d;

  Plane(this.normal, this.d);

  factory Plane.fromPoints(Point3d a, Point3d b, Point3d c) {
    final normal = (b - a).cross(c - a).normalize();
    final d = normal.dot(a);
    return Plane(normal, d);
  }

  double distanceFromPoint(Point3d point) => point.dot(normal) - d;

  @override
  String toString() => 'Plane($normal, $d)';
}

abstract class BaseShape {
  int get width;
  int get depth;
  int get height;
}

abstract class Shape3d extends BaseShape {
  final double halfWidth;
  final double halfDepth;
  final double halfHeight;

  @override
  final int width;
  @override
  final int depth;
  @override
  final int height;

  Shape3d({
    this.width,
    this.depth,
    this.height,
  }) :
    halfWidth = width / 2,
    halfDepth = depth / 2,
    halfHeight = height / 2;

  bool containsPoint(Point3d p) => contains(p.x, p.y, p.z);

  bool contains(num x, num y, num z);
}
