import 'package:voxel_generator/shape/base.dart';
import 'package:voxel_generator/shape/shape_utils.dart';

class Stadium extends Shape3d {
  final int sideLength;

  Stadium({
    this.sideLength,
    int diameter,
  }) : super(
    width: sideLength + diameter,
    depth: diameter,
    height: 1,
  );

  @override
  bool contains(num x, num y, num z) => ShapeUtils.pointInStadium(x, y, sideLength, depth);
}
