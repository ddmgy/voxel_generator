class Point2d {
  final num x;
  final num y;

  const Point2d(this.x, this.y);

  @override
  String toString() => '($x, $y)';
}

class Point3d extends Point2d {
  final num z;

  const Point3d(num x, num y, this.z) : super(x, y);

  @override
  String toString() => '($x, $y, $z)';
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
