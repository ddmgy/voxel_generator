import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:voxel_generator/preference/preferences_provider.dart';
import 'package:voxel_generator/ui/main/home_filter_button.dart';
import 'package:voxel_generator/ui/main/properties_panel.dart';
import 'package:voxel_generator/ui/main/shape_type_selector_panel.dart';
import 'package:voxel_generator/ui/routes.dart';
import 'package:voxel_generator/ui/shape_type.dart';
import 'package:voxel_generator/ui/viewer/main_viewer.dart';
import 'package:voxel_generator/utils.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<PreferencesProvider>(
    builder: (context, prefs, _) => LayoutBuilder(
      builder: (context, constraints) {
        final wideLayout = (constraints.maxWidth - 500) / constraints.maxHeight >= 1;
        final theme = Theme.of(context);
        final checkerBoardColors = <Color>[];
        checkerBoardColors.add(theme.scaffoldBackgroundColor);
        if (theme.brightness == Brightness.dark) {
          checkerBoardColors.add(checkerBoardColors[0].lighten(amount: 30));
        } else {
          checkerBoardColors.add(checkerBoardColors[0].darken(amount: 30));
        }

        final selectedShapeType = prefs.selectedShapeType;
        final shapeTypeSelectorPanel = ShapeTypeSelectorPanel(
          onSelectedChanged: wideLayout ? null : () => Navigator.of(context).pop(),
        );
        final propertiesPanel = PropertiesPanel();
        final mainView = MainViewer();

        Widget body;
        Widget drawer;
        Widget endDrawer;
        if (wideLayout) {
          body = Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 250,
                child: shapeTypeSelectorPanel,
              ),
              // shapeTypeSelectorPanel,
              Expanded(
                child: mainView,
                flex: 1,
              ),
              SizedBox(
                width: 250,
                child: propertiesPanel,
              ),
              // propertiesPanel,
            ],
          );
        } else {
          body = mainView;
          drawer = Drawer(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: shapeTypeSelectorPanel,
            ),
          );
          endDrawer = Drawer(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: propertiesPanel,
            ),
          );
        }


        return Scaffold(
          appBar: AppBar(
            title: Text(selectedShapeType.getName()),
            actions: [
              if (!wideLayout) HomeFilterButton(),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () => Navigator.of(context).pushNamed(Routes.settings),
              ),
            ],
          ),
          body: body,
          drawer: drawer,
          endDrawer: endDrawer,
        );
      },
    ),
  );
}
