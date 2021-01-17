import 'package:test/test.dart';

import 'package:voxel_generator/shape/circle.dart';
import 'package:voxel_generator/shape/cube.dart';
import 'package:voxel_generator/shape/cuboid.dart';
import 'package:voxel_generator/shape/cylinder.dart';
import 'package:voxel_generator/shape/ellipse.dart';
import 'package:voxel_generator/shape/ellipsoid.dart';
import 'package:voxel_generator/shape/rectangle.dart';
import 'package:voxel_generator/shape/sphere.dart';
import 'package:voxel_generator/shape/square.dart';

void main() {
  test('oval', () {
    final oval = Ellipse(
      width: 6,
      height: 4,
    );
    expect(oval.contains(0, 0, 0), isTrue);
    expect(oval.contains(3, 0, 0), isTrue);
    expect(oval.contains(0, -2, 0), isTrue);
    expect(oval.contains(3, 2, 0), isFalse);
  });
  test('circle', () {
    final circle = Circle(
      diameter: 8,
    );
    expect(circle.contains(0, 0, 0), isTrue);
    expect(circle.contains(0, 4, 0), isTrue);
    expect(circle.contains(-4, 0, 0), isTrue);
    expect(circle.contains(0, 5, 0), isFalse);
    expect(circle.contains(0, -4.1, 0), isFalse);
  });
  test('rectangle', () {
    final rect = Rectangle(
      width: 8,
      height: 12,
    );
    expect(rect.contains(0, 0, 0), isTrue);
    expect(rect.contains(4, 6, 0), isTrue);
    expect(rect.contains(0, -6, 0), isTrue);
    expect(rect.contains(-4, -6, 0), isTrue);
    expect(rect.contains(-5, 9, 0), isFalse);
  });
  test('square', () {
    final square = Square(
      sideLength: 3,
    );
    expect(square.contains(0, 0, 0), isTrue);
    expect(square.contains(1.5, -1.5, 0), isTrue);
    expect(square.contains(2, 0, 0), isFalse);
    expect(square.contains(0, 10, 0), isFalse);
  });
  test('ellipsoid', () {
    final ellipsoid = Ellipsoid(
      width: 10,
      depth: 10,
      height: 6,
    );
    expect(ellipsoid.contains(0, 0, 0), isTrue);
    expect(ellipsoid.contains(5, 0, 0), isTrue);
    expect(ellipsoid.contains(0, -5, 0), isTrue);
    expect(ellipsoid.contains(0, 0, 3), isTrue);
    expect(ellipsoid.contains(6, 2, 1), isFalse);
  });
  test('sphere', () {
    final sphere = Sphere(
      diameter: 8,
    );
    expect(sphere.contains(0, 0, 0), isTrue);
  });
  test('cuboid', () {
    final cuboid = Cuboid(
      width: 8,
      depth: 4,
      height: 4,
    );
    expect(cuboid.contains(0, 0, 0), isTrue);
  });
  test('cube', () {
    final cube = Cube(
      sideLength: 5,
    );
    expect(cube.contains(0, 0, 0), isTrue);
  });
  test('cylinder', () {
    final cylinder = Cylinder(
      diameter: 7,
      height: 9,
    );
    expect(cylinder.contains(0, 0, 0), isTrue);
  });
}
