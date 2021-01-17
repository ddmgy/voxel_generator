import 'package:flutter/material.dart';

import 'package:voxel_generator/color_set.dart';
import 'package:voxel_generator/shape/base.dart';
import 'package:voxel_generator/voxel_renderer.dart';

class SliceViewer extends StatelessWidget {
  final double width;
  final ColorSet colors;
  final Shape3d shape;

  SliceViewer({
    Key key,
    @required this.width,
    @required this.colors,
    @required this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = ((width / shape.width) * (shape.depth + 0.5)).ceilToDouble();
    final slices = VoxelRenderer.render(shape);

    return Scrollbar(
      child: ListView.separated(
        itemCount: slices.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: SizedBox(
            width: width,
            height: height,
            child: CustomPaint(
              painter: _SliceViewerPainter(
                colors: colors,
                slice: slices[index],
              ),
              willChange: false,
              isComplex: true,
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

  _SliceViewerPainter({
    @required this.colors,
    @required this.slice,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final pixelSize = size.width / slice[0].length;

    for (var y = 0; y < slice.length; y++) {
      for (var x = 0; x < slice[y].length; x++) {
        if (slice[y][x]) {
          _drawPixel(canvas, pixelSize, x, y);
        }
      }
    }
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
  bool shouldRepaint(_SliceViewerPainter oldDelegate) => colors != oldDelegate.colors;
}