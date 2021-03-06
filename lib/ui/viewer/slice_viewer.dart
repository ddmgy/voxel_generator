import 'package:flutter/material.dart';

import 'package:voxel_generator/ui/color_set.dart';
import 'package:voxel_generator/shape/base.dart';
import 'package:voxel_generator/utils.dart';
import 'package:voxel_generator/ui/voxel_renderer.dart';

class SliceViewer extends StatelessWidget {
  final double width;
  final ColorSet colors;
  final Shape3d shape;
  final List<Color> checkerBoardColors;

  SliceViewer({
    Key key,
    @required this.width,
    @required this.colors,
    @required this.shape,
    @required this.checkerBoardColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = ((width / shape.width) * (shape.depth + 0.5)).ceilToDouble();
    final slices = VoxelRenderer.render(shape);

    return Scrollbar(
      child: ListView.separated(
        itemCount: slices.length,
        itemBuilder: (context, index) => Padding(
          key: ValueKey(Pair(index, shape)),
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: SizedBox(
            width: width,
            height: height,
            child: CustomPaint(
              painter: _SliceViewerPainter(
                colors: colors,
                slice: slices[index],
                checkerBoardColors: checkerBoardColors,
              ),
              willChange: true,
              isComplex: false,
            ),
          ),
        ),
        separatorBuilder: (context, index) => SizedBox(
          height: 24,
        ),
      ),
    );
  }
}

class _SliceViewerPainter extends CustomPainter {
  final ColorSet colors;
  final List<List<bool>> slice;
  final List<Color> checkerBoardColors;
  final int _width;
  final int _height;

  _SliceViewerPainter({
    @required this.colors,
    @required this.slice,
    @required this.checkerBoardColors,
  }) : _width = slice[0].length, _height = slice.length;

  @override
  void paint(Canvas canvas, Size size) {
    final pixelSize = size.width / _width;

    for (var y = 0; y < _height; y++) {
      for (var x = 0; x < _width; x++) {
        if (slice[y][x]) {
          _drawPixel(canvas, pixelSize, x, y);
        } else {
          _drawCheckerBoard(canvas, pixelSize, x, y);
        }
      }
    }
  }

  void _drawCheckerBoard(Canvas canvas, double pixelSize, int x, int y) {
    final index = (x + y * _width + (_width % 2 == 0 && y % 2 == 0 ? 1 : 0)) % checkerBoardColors.length;
    final rect = Rect.fromLTWH(
      x * pixelSize,
      y * pixelSize + (pixelSize / 2),
      pixelSize,
      pixelSize,
    );
    final paint = Paint()
      ..color = checkerBoardColors[index]
      ..style = PaintingStyle.fill;
    canvas.drawRect(rect, paint);
  }

  void _drawPixel(Canvas canvas, double pixelSize, int x, int y) {
    final vertices = [
      Offset(x * pixelSize, (y + 1) * pixelSize),
      Offset(x * pixelSize, y * pixelSize),
      Offset((x + 1) * pixelSize, y * pixelSize),
      Offset((x + 1) * pixelSize, (y + 1) * pixelSize),
      Offset((x + 1) * pixelSize, ((y + 1) * pixelSize) + (.5 * pixelSize)),
      Offset(x * pixelSize, ((y + 1) * pixelSize) + (.5 * pixelSize)),
    ];

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = colors.right;
    _drawRect(canvas, paint, [vertices[0], vertices[1], vertices[2], vertices[3]]);
    paint.color = colors.left;
    _drawRect(canvas, paint, [vertices[0], vertices[3], vertices[4], vertices[5]]);
    if (colors.outline != null) {
      paint.style = PaintingStyle.stroke;
      paint.color = colors.outline;

      _drawRect(canvas, paint, [vertices[0], vertices[1], vertices[2], vertices[3]]);
      _drawRect(canvas, paint, [vertices[0], vertices[3], vertices[4], vertices[5]]);
    }
  }

  void _drawRect(Canvas canvas, Paint paint, List<Offset> vertices) {
    final path = Path();
    path.moveTo(vertices[0].dx, vertices[0].dy);
    path.addPolygon(vertices, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_SliceViewerPainter oldDelegate) => colors != oldDelegate.colors
    && slice != oldDelegate.slice;
}
