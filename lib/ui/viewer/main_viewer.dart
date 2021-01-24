import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:voxel_generator/preference/preferences_provider.dart';
import 'package:voxel_generator/ui/shape_mapper.dart';
import 'package:voxel_generator/ui/viewer/slice_viewer.dart';
import 'package:voxel_generator/ui/viewer/voxel_viewer.dart';
import 'package:voxel_generator/ui/viewer_type.dart';
import 'package:voxel_generator/utils.dart';

class MainViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<PreferencesProvider>(
    builder: (context, prefs, _) => LayoutBuilder(
      builder: (context, constraints) {
        final theme = Theme.of(context);
        final checkerBoardColors = <Color>[];
        checkerBoardColors.add(theme.scaffoldBackgroundColor);
        if (theme.brightness == Brightness.dark) {
          checkerBoardColors.add(checkerBoardColors[0].lighten(amount: 30));
        } else {
          checkerBoardColors.add(checkerBoardColors[0].darken(amount: 30));
        }

        final shape = ShapeMapper.mapToShape(context, prefs.selectedShapeType);

        if (prefs.viewerType == ViewerType.Voxel) {
          return VoxelViewer(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            colors: prefs.colorSet,
            fit: prefs.fit,
            shape: shape,
          );
        } else {
          return SliceViewer(
            width: constraints.maxWidth,
            colors: prefs.colorSet,
            shape: shape,
            checkerBoardColors: checkerBoardColors,
          );
        }
      },
    ),
  );
}
