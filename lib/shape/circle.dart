import 'package:voxel_generator/shape/ellipse.dart';

class Circle extends Ellipse {
  Circle({
    int diameter,
  }) : super(
    width: diameter,
    height: diameter,
  );
}
