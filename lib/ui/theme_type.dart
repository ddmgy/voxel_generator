enum ThemeType {
  Light,
  Dark,
}

extension ThemeTypeExtensions on ThemeType {
  String getName() {
    if (this == ThemeType.Light) {
      return 'Light';
    } else {
      return 'Dark';
    }
  }

  int toInt() => ThemeType.values.indexOf(this);
}

extension IntToThemeTypeExtensions on int {
  ThemeType toThemeType() => ThemeType.values[this.clamp(0, ThemeType.values.length - 1)];
}