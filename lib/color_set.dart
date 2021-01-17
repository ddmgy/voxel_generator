import 'package:flutter/painting.dart';

import 'package:voxel_generator/utils.dart';

class ColorSet {
  final Color right;
  final Color left;
  final Color top;
  final Color outline;
  final bool onlyUseRightFaceColor;

  ColorSet({
    this.right,
    Color left,
    Color top,
    this.outline,
    int variation = 15,
    this.onlyUseRightFaceColor = true,
  }) :
    left = (onlyUseRightFaceColor || left == null) ? right.darken(amount: variation) : left,
    top = (onlyUseRightFaceColor || top == null) ? right.lighten(amount: variation) : top;

  @override
  bool operator ==(Object other) => other is ColorSet
    && right == other.right
    && left == other.left
    && top == other.top
    && outline == other.outline
    && onlyUseRightFaceColor == other.onlyUseRightFaceColor;

  @override
  int get hashCode => hashValues(right, left, top, outline, onlyUseRightFaceColor);
}