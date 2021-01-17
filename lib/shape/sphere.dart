import 'package:voxel_generator/shape/ellipsoid.dart';

class Sphere extends Ellipsoid {
  Sphere({
    int diameter
  }) : super(
    width: diameter,
    depth: diameter,
    height: diameter,
  );
}
