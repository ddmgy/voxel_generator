import 'package:voxel_generator/shape/base.dart';

class VoxelRenderer {
  static List<List<List<bool>>> render(Shape3d shape) {
    final ret = <List<List<bool>>>[];
    final xRadius = (shape.width - 1) / 2;
    final yRadius = (shape.depth - 1) / 2;
    num zStart;
    num zEnd;
    if (shape.height == 1) {
      zStart = 0;
      zEnd = 0;
    } else {
      zStart = -(shape.height - 1) / 2;
      zEnd = -zStart;
    }

    for (var z = zStart; z <= zEnd; z++) {
      final slice = <List<bool>>[];
      for (var y = -yRadius; y <= yRadius; y++) {
        final row = <bool>[];
        for (var x = -xRadius; x <= xRadius; x++) {
          row.add(shape.contains(x, y, z));
        }
        slice.add(row);
      }
      ret.add(slice);
    }

    return ret;
  }
}
