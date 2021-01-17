import 'package:voxel_generator/utils.dart';

enum ViewerType {
  Voxel,
  Slice,
}

extension ViewerTypeExtensions on ViewerType {
  String getName() => toString().substringAfterLast('.');

  int toInt() => index;
}

extension IntToViewerTypeExtensions on int {
  toViewerType() => ViewerType.values[this % ViewerType.values.length];
}

