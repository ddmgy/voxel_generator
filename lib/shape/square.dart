import 'package:voxel_generator/shape/rectangle.dart';

class Square extends Rectangle {
  Square({
    int sideLength,
  }) : super(
    width: sideLength,
    height: sideLength,
  );
}
