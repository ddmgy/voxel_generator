import 'package:flutter/material.dart';

import 'package:voxel_generator/color_set.dart';
import 'package:voxel_generator/option_tile_type.dart';
import 'package:voxel_generator/preference/preferences_helper.dart';
import 'package:voxel_generator/shape_properties.dart';
import 'package:voxel_generator/shape_type.dart';
import 'package:voxel_generator/ui/theme_type.dart';
import 'package:voxel_generator/viewer_type.dart';

// TODO: Customize dark theme
ThemeData _darkTheme = ThemeData(
  brightness: Brightness.dark,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

// TODO: Customize light theme
ThemeData _lightTheme = ThemeData(
  brightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper _prefs = PreferencesHelper.instance;

  ThemeType _themeType = ThemeType.Light;
  ThemeType get themeType => _themeType;
  set themeType(ThemeType newValue) {
    if (newValue == null || newValue == _themeType) {
      return;
    }
    _themeType = newValue;
    notifyListeners();
    _prefs.setTheme(_themeType);
  }

  ThemeData get theme {
    switch (_themeType) {
      case ThemeType.Light:
        return _lightTheme;
      case ThemeType.Dark:
        return _darkTheme;
    }
    throw Exception('unreachable');
  }

  ShapeType _selectedShapeType = ShapeType.values.first;
  ShapeType get selectedShapeType => _selectedShapeType;
  set selectedShapeType(ShapeType newValue) {
    if (newValue == null || newValue == _selectedShapeType) {
      return;
    }
    _selectedShapeType = newValue;
    notifyListeners();
    _prefs.setSelectedShapeType(_selectedShapeType);
  }

  Map<String, int> _shapeProperties = {};

  String _shapePropertiesKey(ShapeType shapeType, String property) => '${shapeType.getName()}__${property}';

  int getShapeProperty(ShapeType shapeType, String property, [int defaultValue = 0]) {
    final key = _shapePropertiesKey(shapeType, property);
    return _shapeProperties[key] ?? defaultValue;
  }

  void setShapeProperty(ShapeType shapeType, String property, int value) {
    _shapeProperties[_shapePropertiesKey(shapeType, property)] = value;
    notifyListeners();
    _prefs.setShapeProperty(shapeType, property, value);
  }

  BoxFit _fit = BoxFit.fitWidth;
  BoxFit get fit => _fit;
  set fit(BoxFit newValue) {
    if (newValue == null || newValue == _fit) {
      return;
    }
    _fit = newValue;
    notifyListeners();
    _prefs.setFit(_fit);
  }

  Map<String, bool> _tileExpandeds = {};

  bool getTileExpanded(String tileType) => _tileExpandeds[tileType] ?? false;

  void setTileExpanded(String tileType, bool expanded) {
    _tileExpandeds[tileType] = expanded;
    notifyListeners();
    _prefs.setTileExpanded(tileType, expanded);
  }

  ColorSet _colorSet = ColorSet(
    right: Color(0xFF26679C),
    onlyUseRightFaceColor: true,
  );
  ColorSet get colorSet => _colorSet;

  void _updateColorSet() {
    _colorSet = ColorSet(
      right: _rightFaceColor,
      left: _leftFaceColor,
      top: _topFaceColor,
      outline: _outlineColor,
      onlyUseRightFaceColor: _onlyUseRightFaceColor,
    );
  }

  Color _rightFaceColor = Color(0xFF26679C);
  Color get rightFaceColor => _rightFaceColor;
  set rightFaceColor(Color newValue) {
    if (newValue == null || newValue == _rightFaceColor) {
      return;
    }
    _rightFaceColor = newValue;
    _updateColorSet();
    notifyListeners();
    _prefs.setRightFaceColor(_rightFaceColor);
  }

  Color _leftFaceColor = Color(0xFF6795BA);
  Color get leftFaceColor => _leftFaceColor;
  set leftFaceColor(Color newValue) {
    if (newValue == null || newValue == _leftFaceColor) {
      return;
    }
    _leftFaceColor = newValue;
    _updateColorSet();
    notifyListeners();
    _prefs.setLeftFaceColor(_leftFaceColor);
  }

  Color _topFaceColor = Color(0xFF1E527D);
  Color get topFaceColor => _topFaceColor;
  set topFaceColor(Color newValue) {
    if (newValue == null || newValue == _topFaceColor) {
      return;
    }
    _topFaceColor = newValue;
    _updateColorSet();
    notifyListeners();
    _prefs.setTopFaceColor(_topFaceColor);
  }

  Color _outlineColor = Colors.transparent;
  Color get outlineColor => _outlineColor;
  set outlineColor(Color newValue) {
    if (newValue == null || newValue == _outlineColor) {
      return;
    }
    _outlineColor = newValue;
    _updateColorSet();
    notifyListeners();
    _prefs.setOutlineColor(_outlineColor);
  }

  bool _onlyUseRightFaceColor = true;
  bool get onlyUseRightFaceColor => _onlyUseRightFaceColor;
  set onlyUseRightFaceColor(bool newValue) {
    if (newValue == null || newValue == _onlyUseRightFaceColor) {
      return;
    }
    _onlyUseRightFaceColor = newValue;
    _updateColorSet();
    notifyListeners();
    _prefs.setOnlyUseRightFaceColor(_onlyUseRightFaceColor);
  }

  ViewerType _viewerType = ViewerType.Voxel;
  ViewerType get viewerType => _viewerType;
  set viewerType(ViewerType newValue) {
    if (newValue == null || newValue == _viewerType) {
      return;
    }
    _viewerType = newValue;
    notifyListeners();
    _prefs.setViewerType(_viewerType);
  }

  PreferencesProvider() {
    _initPreferences();
  }

  Future<void> _initPreferences() async {
    // Initialize preferences with values saved in SharedPreferences
    // Set backing fields directly (_count rather than count)
    // so notifyListeners is only called once.
    _themeType = await _prefs.getTheme();
    _selectedShapeType = await _prefs.getSelectedShapeType();
    for (final shapeType in ShapeType.values) {
      for (final property in ShapeProperties.all) {
        final key = _shapePropertiesKey(shapeType, property);
        _shapeProperties[key] = await _prefs.getShapeProperty(shapeType, property, 8);
      }
    }
    _fit = await _prefs.getFit();
    for (final tileType in OptionTileType.all) {
      _tileExpandeds[tileType] = await _prefs.getTileExpanded(tileType);
    }
    _rightFaceColor = await _prefs.getRightFaceColor();
    _leftFaceColor = await _prefs.getLeftFaceColor();
    _topFaceColor = await _prefs.getTopFaceColor();
    _outlineColor = await _prefs.getOutlineColor();
    _onlyUseRightFaceColor = await _prefs.getOnlyUseRightFaceColor();
    _updateColorSet();
    _viewerType = await _prefs.getViewerType();
    notifyListeners();
  }

  void clearPreferences() async {
    await _prefs.clear();
    _shapeProperties.clear();
    _tileExpandeds.clear();
    _initPreferences();
  }
}
