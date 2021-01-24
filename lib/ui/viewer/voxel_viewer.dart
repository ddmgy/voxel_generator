import 'dart:math' as Math;

import 'package:flutter/material.dart';

import 'package:voxel_generator/ui/color_set.dart';
import 'package:voxel_generator/shape/base.dart';
import 'package:voxel_generator/ui/voxel_renderer.dart';
import 'package:voxel_generator/utils.dart';


final cosThirty = Math.cos(Math.pi / 6);
final sinThirty = Math.sin(Math.pi / 6);

class VoxelViewer extends StatelessWidget {
  final double width;
  final double height;
  final ColorSet colors;
  final BoxFit fit;
  final Shape3d shape;

  VoxelViewer({
    Key key,
    @required this.width,
    @required this.height,
    @required this.colors,
    @required this.fit,
    @required this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
    width: width,
    height: height,
    child: CustomPaint(
      painter: _VoxelViewerPainter(
        maxWidth: width,
        maxHeight: height,
        colors: colors,
        fit: fit,
        shape: shape,
      ),
      willChange: false,
      isComplex: true,
    ),
  );
}

// Most of this is lifted from the backend for new.oranj.io/sphere.
// Source at https://github.com/oranj/Voxel/blob/master/src/voxel/Renderer/CanvasRenderer.ts
class _VoxelViewerPainter extends CustomPainter {
  final double maxWidth;
  final double maxHeight;
  final ColorSet colors;
  final BoxFit fit;
  final Shape3d shape;
  final double _margin = 4;
  double _diamondLength;
  double _shortOffset;
  double _longOffset;
  List<Point2d> _offsets;
  List<List<List<bool>>> _rendered;

  _VoxelViewerPainter({
    @required this.maxWidth,
    @required this.maxHeight,
    @required this.colors,
    @required this.fit,
    @required this.shape,
  }) {
    _getMetrics();
  }

  double _diamondLengthFitToWidth() => (maxWidth - 2 * _margin) / ((shape.width + shape.depth) * cosThirty);

  double _diamondLengthFitToHeight() => (maxHeight - 2 * _margin) / (shape.height + ((shape.width + shape.depth) / 2));

  void _getMetrics() {
    final diamondLengthForWidth = _diamondLengthFitToWidth();
    final diamondLengthForHeight = _diamondLengthFitToHeight();
    if (fit == BoxFit.fitWidth) {
      _diamondLength = diamondLengthForWidth;
    } else if (fit == BoxFit.fitHeight) {
      _diamondLength = diamondLengthForHeight;
    } else { // BoxFit.contain
      _diamondLength = Math.min(diamondLengthForWidth, diamondLengthForHeight);
    }
    _shortOffset = _diamondLength * sinThirty;
    _longOffset = _diamondLength * cosThirty;
    _offsets = [
      Point2d(0, 0),
      Point2d(_longOffset, _shortOffset),
      Point2d(2 * _longOffset, 0),
      Point2d(2 * _longOffset, -2 * _shortOffset),
      Point2d(_longOffset, -_shortOffset),
      Point2d(0, -2 * _shortOffset),
      Point2d(_longOffset, 3 * -_shortOffset),
    ];
  }

  Point2d _project(num x, num y, num z, Point2d origin) => Point2d(
    _margin + origin.x + (_longOffset * (x + y)),
    _margin + origin.y + (_shortOffset * (y - x)) + (_diamondLength * -1 * z),
  );

  Point2d _getOrigin(num width, num depth, num height) {
    final volumeWidth = (width + depth) * _longOffset;
    final volumeHeight = (height * _diamondLength) + ((width + depth) * _shortOffset);
    return Point2d(
      ((maxWidth - 2 * _margin) / 2) - (volumeWidth / 2),
      volumeHeight - (depth * _shortOffset),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (_rendered == null) {
      _rendered = VoxelRenderer.render(shape);
    }
    final totalX = _rendered[0][0].length;
    final totalY = _rendered[0].length;
    final totalZ = _rendered.length;
    final origin = _getOrigin(totalX, totalY, totalZ);
    final isCulled = <String, num>{};
    final planes = <List<Point3d>>[];
    for (var i = 0; i < totalX + totalY + totalZ; i++) {
      planes.add([]);
    }
    final startZ = totalZ - 1;
    final xSub = totalX - 1;

    for (var z = startZ; z >= 0; z--) {
      for (var y = 0; y < totalY; y++) {
        for (var x = xSub; x >= 0; x--) {
          if (!_rendered[z][y][x]) {
            continue;
          }
          final x2 = xSub - x;
          final min = [x2, y, z].min();
          final key = [x2 - min, y - min, z - min].join(':');
          final plane = x2 + y + z;
          if (isCulled.containsKey(key)) {
            continue;
          }
          isCulled[key] = plane;
          planes[plane].add(Point3d(x, y, z));
        }
      }
    }

    for (final plane in planes) {
      for (final p in plane) {
        final pos = _project(p.x, p.y, p.z, origin);
        _drawCube(canvas, pos);
      }
    }
  }

  void _drawCube(Canvas canvas, Point2d point) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    paint.color = colors.left;
    _drawDiamond(
      canvas, paint, point,
      [_offsets[0], _offsets[1], _offsets[4], _offsets[5]],
    );

    paint.color = colors.right;
    _drawDiamond(
      canvas, paint, point,
      [_offsets[1], _offsets[2], _offsets[3], _offsets[4]],
    );

    paint.color = colors.top;
    _drawDiamond(
      canvas, paint, point,
      [_offsets[3], _offsets[4], _offsets[5], _offsets[6]],
    );

    if (colors.outline != null) {
      paint.color = colors.outline;
      paint.style = PaintingStyle.stroke;
      _drawDiamond(
        canvas, paint, point,
        [_offsets[0], _offsets[1], _offsets[4], _offsets[5]],
      );
      _drawDiamond(
        canvas, paint, point,
        [_offsets[1], _offsets[2], _offsets[3], _offsets[4]],
      );
      _drawDiamond(
        canvas, paint, point,
        [_offsets[3], _offsets[4], _offsets[5], _offsets[6]],
      );
    }
  }

  void _drawDiamond(Canvas canvas, Paint paint, Point2d origin, List<Point2d> points) {
    final path = Path();
    final offsets = points.map((o) => Offset((origin.x + o.x).roundToDouble(), (origin.y + o.y).roundToDouble())).toList();
    path.moveTo(offsets[0].dx, offsets[0].dy);
    path.addPolygon(offsets, true);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_VoxelViewerPainter oldDelegate) => _diamondLength != oldDelegate._diamondLength;
}
