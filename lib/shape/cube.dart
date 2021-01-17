import 'package:voxel_generator/shape/cuboid.dart';

class Cube extends Cuboid {
  Cube({
    int sideLength,
  }) : super(
    width: sideLength,
    depth: sideLength,
    height: sideLength,
  );
}
