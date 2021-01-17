import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import 'package:voxel_generator/preference/preferences_provider.dart';
import 'package:voxel_generator/shape_properties.dart';
import 'package:voxel_generator/shape_type.dart';
import 'package:voxel_generator/shape/base.dart';
import 'package:voxel_generator/shape/circle.dart';
import 'package:voxel_generator/shape/cube.dart';
import 'package:voxel_generator/shape/cuboid.dart';
import 'package:voxel_generator/shape/cylinder.dart';
import 'package:voxel_generator/shape/ellipse.dart';
import 'package:voxel_generator/shape/ellipsoid.dart';
import 'package:voxel_generator/shape/rectangle.dart';
import 'package:voxel_generator/shape/sphere.dart';
import 'package:voxel_generator/shape/square.dart';
import 'package:voxel_generator/ui/filter_fit_button.dart';
import 'package:voxel_generator/ui/property_button.dart';
import 'package:voxel_generator/ui/routes.dart';
import 'package:voxel_generator/ui/slice_viewer.dart';
import 'package:voxel_generator/ui/viewer_type_button.dart';
import 'package:voxel_generator/ui/voxel_viewer.dart';
import 'package:voxel_generator/utils.dart';
import 'package:voxel_generator/viewer_type.dart';

typedef ColorPreferenceSetter = Function(Color newColor);

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<PreferencesProvider>(
    builder: (context, prefs, _) {
      final selectedShapeType = prefs.selectedShapeType;
      final drawerChildren = <Widget>[];

      for (final shapeType in ShapeType.values) {
        final tile = ListTile(
          title: Text(
            shapeType.getName(),
            style: context.titleTextStyle(),
          ),
          dense: true,
          selected: shapeType == selectedShapeType,
          onTap: () {
            prefs.selectedShapeType = shapeType;
            Navigator.of(context).pop();
          },
        );
        drawerChildren.add(tile);
      }

      final endDrawerChild = _getEndDrawerForShapeType(context, selectedShapeType);

      return Scaffold(
        appBar: AppBar(
          title: Text(selectedShapeType.getName()),
          actions: [
            HomeFilterButton(),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => Navigator.of(context).pushNamed(Routes.settings),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: drawerChildren,
          ),
        ),
        endDrawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: endDrawerChild,
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final maxHeight = constraints.maxHeight;
            final shape = _getShapeForShapeType(context, selectedShapeType);

            if (prefs.viewerType == ViewerType.Voxel) {
              return VoxelViewer(
                width: maxWidth,
                height: maxHeight,
                colors: prefs.colorSet,
                fit: prefs.fit,
                shape: shape,
              );
            } else {
              return SliceViewer(
                width: maxWidth,
                colors: prefs.colorSet,
                shape: shape,
              );
            }
          },
        ),
      );
    }
  );

  Widget _getEndDrawerForShapeType(BuildContext context, ShapeType shapeType) {
    final prefs = Provider.of<PreferencesProvider>(context, listen: false);

    final children = <Widget>[
      ViewerTypeButton(),
    ];

    if (prefs.viewerType == ViewerType.Voxel) {
      children.add(FilterFitButton());
    }

    final properties = <Widget>[];
    if (shapeType == ShapeType.Circle) {
      properties.add(PropertyDiameterButton(shapeType: shapeType));
    } else if (shapeType == ShapeType.Cube) {
      properties.add(PropertySideLengthButton(shapeType: shapeType));
    } else if (shapeType == ShapeType.Cuboid) {
      properties.add(PropertyWidthButton(shapeType: shapeType));
      properties.add(PropertyDepthButton(shapeType: shapeType));
      properties.add(PropertyHeightButton(shapeType: shapeType));
    } else if (shapeType == ShapeType.Cylinder) {
      properties.add(PropertyDiameterButton(shapeType: shapeType));
      properties.add(PropertyHeightButton(shapeType: shapeType));
    } else if (shapeType == ShapeType.Ellipse) {
      properties.add(PropertyWidthButton(shapeType: shapeType));
      properties.add(PropertyHeightButton(shapeType: shapeType));
    } else if (shapeType == ShapeType.Ellipsoid) {
      properties.add(PropertyWidthButton(shapeType: shapeType));
      properties.add(PropertyDepthButton(shapeType: shapeType));
      properties.add(PropertyHeightButton(shapeType: shapeType));
    } else if (shapeType == ShapeType.Rectangle) {
      properties.add(PropertyWidthButton(shapeType: shapeType));
      properties.add(PropertyHeightButton(shapeType: shapeType));
    } else if (shapeType == ShapeType.Sphere) {
      properties.add(PropertyDiameterButton(shapeType: shapeType));
    } else if (shapeType == ShapeType.Square) {
      properties.add(PropertySideLengthButton(shapeType: shapeType));
    }
    final propertiesTile = ExpansionTile(
      leading: Icon(
        Icons.edit,
        color: context.iconColor(),
      ),
      title: Text(
        'Properties',
        style: context.titleTextStyle(),
      ),
      children: properties,
      initiallyExpanded: prefs.getTileExpanded('properties'),
      onExpansionChanged: (bool expanded) {
        prefs.setTileExpanded('properties', expanded);
      },
    );
    children.add(propertiesTile);

    final colorPreferences = <Widget>[];
    colorPreferences.add(ListTile(
      trailing: _colorIcon(prefs.rightFaceColor),
      title: Text(
        'Right face',
        style: context.titleTextStyle(),
      ),
      onTap: () => _showColorPickerDialog(
        context,
        prefs.rightFaceColor,
        (Color newColor) => prefs.rightFaceColor = newColor,
      ),
    ));
    colorPreferences.add(ListTile(
      trailing: _colorIcon(prefs.leftFaceColor),
      title: Text(
        'Left face',
        style: context.titleTextStyle(),
      ),
      onTap: () => _showColorPickerDialog(
        context,
        prefs.leftFaceColor,
        (Color newColor) => prefs.leftFaceColor = newColor,
      ),
    ));
    colorPreferences.add(ListTile(
      trailing: _colorIcon(prefs.topFaceColor),
      title: Text(
        'Top face',
        style: context.titleTextStyle(),
      ),
      onTap: () => _showColorPickerDialog(
        context,
        prefs.topFaceColor,
        (Color newColor) => prefs.topFaceColor = newColor,
      ),
    ));
    colorPreferences.add(ListTile(
      trailing: _colorIcon(prefs.outlineColor),
      title: Text(
        'Outline',
        style: context.titleTextStyle(),
      ),
      onTap: () => _showColorPickerDialog(
        context,
        prefs.outlineColor,
        (Color newColor) => prefs.outlineColor = newColor,
      ),
    ));
    colorPreferences.add(ListTile(
      trailing: Checkbox(
        value: prefs.onlyUseRightFaceColor,
        onChanged: (bool newValue) => prefs.onlyUseRightFaceColor = newValue,
      ),
      title: Text(
        'Only use right face',
        style: context.titleTextStyle(),
      ),
      onTap: () => prefs.onlyUseRightFaceColor = !prefs.onlyUseRightFaceColor,
    ));

    final colorPreferencesTile = ExpansionTile(
      leading: Icon(
        Icons.color_lens,
        color: context.iconColor(),
      ),
      title: Text(
        'Colors',
        style: context.titleTextStyle(),
      ),
      children: colorPreferences,
      initiallyExpanded: prefs.getTileExpanded('colors'),
      onExpansionChanged: (bool expanded) {
        prefs.setTileExpanded('colors', expanded);
      },
    );
    children.add(colorPreferencesTile);

    return ListView(
      children: children,
    );
  }

  Shape3d _getShapeForShapeType(BuildContext context, ShapeType shapeType) {
    final prefs = Provider.of<PreferencesProvider>(context, listen: false);

    if (shapeType == ShapeType.Circle) {
      return Circle(
        diameter: prefs.getShapeProperty(shapeType, ShapeProperties.diameter, 8),
      );
    } else if (shapeType == ShapeType.Cube) {
      return Cube(
        sideLength: prefs.getShapeProperty(shapeType, ShapeProperties.sideLength, 8),
      );
    } else if (shapeType == ShapeType.Cuboid) {
      return Cuboid(
        width: prefs.getShapeProperty(shapeType, ShapeProperties.width, 8),
        depth: prefs.getShapeProperty(shapeType, ShapeProperties.depth, 8),
        height: prefs.getShapeProperty(shapeType, ShapeProperties.height, 8),
      );
    } else if (shapeType == ShapeType.Cylinder) {
      return Cylinder(
        diameter: prefs.getShapeProperty(shapeType, ShapeProperties.diameter, 8),
        height: prefs.getShapeProperty(shapeType, ShapeProperties.height, 8),
      );
    } else if (shapeType == ShapeType.Ellipse) {
      return Ellipse(
        width: prefs.getShapeProperty(shapeType, ShapeProperties.width, 8),
        height: prefs.getShapeProperty(shapeType, ShapeProperties.height, 8),
      );
    } else if (shapeType == ShapeType.Ellipsoid) {
      return Ellipsoid(
        width: prefs.getShapeProperty(shapeType, ShapeProperties.width, 8),
        depth: prefs.getShapeProperty(shapeType, ShapeProperties.depth, 8),
        height: prefs.getShapeProperty(shapeType, ShapeProperties.height, 8),
      );
    } else if (shapeType == ShapeType.Rectangle) {
      return Rectangle(
        width: prefs.getShapeProperty(shapeType, ShapeProperties.width, 8),
        height: prefs.getShapeProperty(shapeType, ShapeProperties.height, 8),
      );
    } else if (shapeType == ShapeType.Sphere) {
      return Sphere(
        diameter: prefs.getShapeProperty(shapeType, ShapeProperties.diameter, 8),
      );
    } else if (shapeType == ShapeType.Square) {
      return Square(
        sideLength: prefs.getShapeProperty(shapeType, ShapeProperties.sideLength, 8),
      );
    }
    throw Exception('unreachable');
  }

  Widget _colorIcon(Color color) => AnimatedContainer(
    color: color,
    height: 24,
    width: 24,
    duration: kThemeChangeDuration,
  );

  void _showColorPickerDialog(
    BuildContext context,
    Color initialColor,
    ColorPreferenceSetter onColorChanged,
  ) async {
    final result = await showDialog<Color>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Choose a color',
          style: context.titleTextStyle(),
        ),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: initialColor,
            showLabel: true,
            onColorChanged: (Color color) => initialColor = color,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: [
          FlatButton(
            child: Text(
              'Cancel',
              style: context.subtitleTextStyle(),
            ),
            onPressed: () => Navigator.of(context).pop(null),
          ),
          FlatButton(
            child: Text(
              'OK',
              style: context.subtitleTextStyle(),
            ),
            onPressed: () => Navigator.of(context).pop(initialColor),
          ),
        ],
      ),
    );

    if (result != null) {
      onColorChanged(result);
    }
  }
}

// class CanvasSize {
//   final num width;
//   final num height;
//   final Point2d origin;
//
//   CanvasSize({
//     this.width,
//     this.height,
//     this.origin,
//   });
//
//   @override
//   String toString() => '(w: $width, h: $height, o: $origin';
// }
//
// // Most of this is lifted from the backend for new.oranj.io/sphere.
// // Source at https://github.com/oranj/Voxel/blob/master/src/voxel/Renderer/CanvasRenderer.ts
// class VoxelViewer extends CustomPainter {
//   final Shape3d shape;
//   final ColorSet colors;
//   final BoxFit fit;
//   final double maxWidth;
//   final double maxHeight;
//   final double _margin = 4;
//   double _diamondLength;
//   double _shortOffset;
//   double _longOffset;
//   List<Point2d> _offsets;
//   List<List<List<bool>>> _rendered;
//
//   VoxelViewer({
//     this.shape,
//     this.colors,
//     this.fit,
//     this.maxWidth,
//     this.maxHeight,
//   }) {
//     _getMetrics();
//     _offsets = [
//       Point2d(0, 0),
//       Point2d(_longOffset, _shortOffset),
//       Point2d(2 * _longOffset, 0),
//       Point2d(2 * _longOffset, -2 * _shortOffset),
//       Point2d(_longOffset, -_shortOffset),
//       Point2d(0, -2 * _shortOffset),
//       Point2d(_longOffset, 3 * -_shortOffset),
//     ];
//   }
//
//   double _diamondLengthFitToWidth() => (maxWidth - 2 * _margin) / ((shape.width + shape.depth) * COS_THIRTY);
//
//   double _diamondLengthFitToHeight() => (maxHeight - 2 * _margin) / (shape.height + ((shape.width + shape.depth) / 2));
//
//   void _getMetrics() {
//     final diamondLengthForWidth = _diamondLengthFitToWidth();
//     final diamondLengthForHeight = _diamondLengthFitToHeight();
//     if (fit == BoxFit.fitWidth) {
//       _diamondLength = diamondLengthForWidth;
//     } else if (fit == BoxFit.fitHeight) {
//       _diamondLength = diamondLengthForHeight;
//     } else { // BoxFit.contain
//       _diamondLength = Math.min(diamondLengthForWidth, diamondLengthForHeight);
//     }
//     _shortOffset = _diamondLength * SIN_THIRTY;
//     _longOffset = _diamondLength * COS_THIRTY;
//   }
//
//   Point2d _project(num x, num y, num z, Point2d origin) => Point2d(
//     _margin + origin.x + (_longOffset * (x + y)),
//     _margin + origin.y + (_shortOffset * (y - x)) + (_diamondLength * -1 * z),
//   );
//
//   CanvasSize _getCanvasSize(num width, num depth, num height) {
//     final canvasWidth = (width + depth) * _longOffset;
//     final canvasHeight = (height * _diamondLength) + ((width + depth) * _shortOffset);
//     return CanvasSize(
//       width: canvasWidth,
//       height: canvasHeight,
//       origin: Point2d(
//         ((maxWidth - 2 * _margin) / 2) - (canvasWidth / 2),
//         canvasHeight - ((depth) * _shortOffset),
//       ),
//     );
//   }
//
//   @override
//   void paint(Canvas canvas, Size canvasSize) {
//     if (_rendered == null) {
//       _rendered = VoxelRenderer.render(shape);
//     }
//     // print(canvasSize);
//     final totalX = _rendered[0][0].length;
//     final totalY = _rendered[0].length;
//     final totalZ = _rendered.length;
//     final size = _getCanvasSize(totalX, totalY, totalZ);
//     // print(size);
//     final isCulled = <String, num>{};
//     final planes = <List<Point3d>>[];
//     for (var i = 0; i < totalX + totalY + totalZ; i++) {
//       planes.add([]);
//     }
//     final startZ = totalZ - 1;
//     final xSub = totalX - 1;
//
//     for (var z = startZ; z >= 0; z--) {
//       for (var y = 0; y < totalY; y++) {
//         for (var x = xSub; x >= 0; x--) {
//           if (!_rendered[z][y][x]) {
//             continue;
//           }
//           final x2 = xSub - x;
//           final min = [x2, y, z].min();
//           final key = [x2 - min, y - min, z - min].join(':');
//           final plane = x2 + y + z;
//           if (isCulled.containsKey(key)) {
//             continue;
//           }
//           isCulled[key] = plane;
//           planes[plane].add(Point3d(x, y, z));
//         }
//       }
//     }
//
//     for (final plane in planes) {
//       for (final p in plane) {
//         final pos = _project(p.x, p.y, p.z, size.origin);
//         // print('draw cube at $pos');
//         _drawCube(canvas, pos);
//       }
//     }
//   }
//
//   void _drawCube(Canvas canvas, Point2d point) {
//     final paint = Paint()
//       ..style = PaintingStyle.fill;
//
//     paint.color = colors.left;
//     _drawDiamond(
//       canvas, paint, point,
//       [_offsets[0], _offsets[1], _offsets[4], _offsets[5]],
//     );
//
//     paint.color = colors.right;
//     _drawDiamond(
//       canvas, paint, point,
//       [_offsets[1], _offsets[2], _offsets[3], _offsets[4]],
//     );
//
//     paint.color = colors.top;
//     _drawDiamond(
//       canvas, paint, point,
//       [_offsets[3], _offsets[4], _offsets[5], _offsets[6]],
//     );
//
//     if (colors.outline != null) {
//       paint.color = colors.outline;
//       paint.style = PaintingStyle.stroke;
//       _drawDiamond(
//         canvas, paint, point,
//         [_offsets[0], _offsets[1], _offsets[4], _offsets[5]],
//       );
//       _drawDiamond(
//         canvas, paint, point,
//         [_offsets[1], _offsets[2], _offsets[3], _offsets[4]],
//       );
//       _drawDiamond(
//         canvas, paint, point,
//         [_offsets[3], _offsets[4], _offsets[5], _offsets[6]],
//       );
//     }
//   }
//
//   void _drawDiamond(Canvas canvas, Paint paint, Point2d origin, List<Point2d> points) {
//     final path = Path();
//     final offsets = points.map((o) => Offset((origin.x + o.x).roundToDouble(), (origin.y + o.y).roundToDouble())).toList();
//     path.moveTo(offsets[0].dx, offsets[0].dy);
//     path.addPolygon(offsets, true);
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(VoxelViewer oldDelegate) => _diamondLength != oldDelegate._diamondLength;
// }

class HomeFilterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => IconButton(
    icon: Icon(Icons.filter_list),
    onPressed: () => Scaffold.of(context).openEndDrawer(),
  );
}