import 'package:flutter/painting.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:voxel_generator/ui/shape_type.dart';
import 'package:voxel_generator/ui/theme_type.dart';
import 'package:voxel_generator/utils.dart';
import 'package:voxel_generator/ui/viewer_type.dart';

class PreferencesHelper {
  static final PreferencesHelper instance = PreferencesHelper._();

  static SharedPreferences _preferences;
  Future<SharedPreferences> get preferences async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _preferences;
  }

  PreferencesHelper._();

  Future<bool> clear() async {
    final prefs = await preferences;
    return prefs.clear();
  }

  Future<ThemeType> getTheme() async {
    final prefs = await preferences;
    return (prefs.getInt(PreferenceKeys.theme) ?? 0).toThemeType();
  }

  Future<void> setTheme(ThemeType themeType) async {
    final prefs = await preferences;
    prefs.setInt(PreferenceKeys.theme, themeType.toInt());
  }

  Future<ShapeType> getSelectedShapeType() async {
    final prefs = await preferences;
    return (prefs.getInt(PreferenceKeys.selectedShapeType) ?? 0).toShapeType();
  }

  Future<void> setSelectedShapeType(ShapeType selectedShapeType) async {
    final prefs = await preferences;
    prefs.setInt(PreferenceKeys.selectedShapeType, selectedShapeType.toInt());
  }

  Future<int> getShapeProperty(ShapeType shapeType, String property, [int defaultValue = 0]) async {
    final prefs = await preferences;
    return prefs.getInt(PreferenceKeys.shapeProperty(shapeType, property)) ?? defaultValue;
  }

  Future<void> setShapeProperty(ShapeType shapeType, String property, int value) async {
    final prefs = await preferences;
    prefs.setInt(PreferenceKeys.shapeProperty(shapeType, property), value);
  }

  Future<BoxFit> getFit() async {
    final prefs = await preferences;
    return (prefs.getInt(PreferenceKeys.fit) ?? 4).toBoxFit();
  }

  Future<void> setFit(BoxFit fit) async {
    final prefs = await preferences;
    prefs.setInt(PreferenceKeys.fit, fit.toInt());
  }

  Future<bool> getTileExpanded(String tileType) async {
    final prefs = await preferences;
    return prefs.getBool(PreferenceKeys.tileExpanded(tileType)) ?? false;
  }

  Future<void> setTileExpanded(String tileType, bool expanded) async {
    final prefs = await preferences;
    prefs.setBool(PreferenceKeys.tileExpanded(tileType), expanded);
  }

  Future<Color> _getColorPreference(String key, int defaultValue) async {
    final prefs = await preferences;
    return Color(prefs.getInt(key) ?? defaultValue);
  }

  Future<void> _setColorPreference(String key, Color color) async {
    final prefs = await preferences;
    prefs.setInt(key, color.value);
  }

  Future<Color> getRightFaceColor() async
    => await _getColorPreference(PreferenceKeys.faceColor('right'), 0xFF26679C);

  Future<void> setRightFaceColor(Color color) async
    => _setColorPreference(PreferenceKeys.faceColor('right'), color);

  Future<Color> getLeftFaceColor() async
    => await _getColorPreference(PreferenceKeys.faceColor('left'), 0xFF6795BA);

  Future<void> setLeftFaceColor(Color color) async
    => _setColorPreference(PreferenceKeys.faceColor('left'), color);

  Future<Color> getTopFaceColor() async
    => await _getColorPreference(PreferenceKeys.faceColor('top'), 0xFF1E527D);

  Future<void> setTopFaceColor(Color color) async
    => _setColorPreference(PreferenceKeys.faceColor('top'), color);

  Future<Color> getOutlineColor() async
    => await _getColorPreference(PreferenceKeys.outlineColor, 0x00000000);

  Future<void> setOutlineColor(Color color) async
    => _setColorPreference(PreferenceKeys.outlineColor, color);

  Future<bool> getOnlyUseRightFaceColor() async {
    final prefs = await preferences;
    return prefs.getBool(PreferenceKeys.onlyUseRightFaceColor) ?? true;
  }

  Future<void> setOnlyUseRightFaceColor(bool onlyUseRightFaceColor) async {
    final prefs = await preferences;
    prefs.setBool(PreferenceKeys.onlyUseRightFaceColor, onlyUseRightFaceColor);
  }

  Future<ViewerType> getViewerType() async {
    final prefs = await preferences;
    return (prefs.getInt(PreferenceKeys.viewer) ?? 0).toViewerType();
  }

  Future<void> setViewerType(ViewerType viewerType) async {
    final prefs = await preferences;
    prefs.setInt(PreferenceKeys.viewer, viewerType.toInt());
  }
}

// Keys used to reference values stored in SharedPreferences
class PreferenceKeys {
  static String get theme => 'theme';

  static String get selectedShapeType => 'selected_shape_type';

  static String shapeProperty(ShapeType shapeType, String property) => '${shapeType.getName()}__${property}';

  static String get fit => 'fit';

  static String tileExpanded(String tileType) => 'tile_expanded_${tileType}';

  static String faceColor(String face) => '${face}_face_color';

  static String get outlineColor => 'outline_color';

  static String get onlyUseRightFaceColor => 'only_use_right_face_color';

  static String get viewer => 'viewer';
}

// Static entries to be used with preferences_ui
// List of possible values that can be stored in SharedPreferences
class PreferenceValues {
  static List<ThemeType> get themes => ThemeType.values;

  static List<BoxFit> get fits => [BoxFit.fitWidth, BoxFit.fitHeight, BoxFit.contain];
}

// Static entries to be used in preferences_ui
// List of names of values that can be stored in SharedPreferences
class PreferenceEntries {
  static List<String> get themes => PreferenceValues.themes.map((themeType) => themeType.getName()).toList();
}
