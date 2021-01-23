import 'dart:math' as Math;

import 'package:flutter/material.dart';

class Pair<T, U> {
  final T first;
  final U last;

  const Pair(this.first, this.last);

  @override
  bool operator ==(Object other) => other is Pair
    && first == other.first
    && last == other.last;

  @override
  int get hashCode => hashValues(first, last);
}

extension StringExtensions on String {
  String substringAfterLast(String s) => substring(lastIndexOf(s) + 1);

  String substringAfter(String s) => substring(indexOf(s) + 1);
}

extension NumIterableExtensions<T extends num> on Iterable<T> {
  T min() => reduce((a, b) => Math.min(a, b));
}

extension IterableExtensions<T> on Iterable<T> {
  bool all(bool Function(T element) test) {
    for (T element in this) {
      if (!test(element)) {
        return false;
      }
    }
    return true;
  }
}

// lighten and darken methods copied from [tinycolor package](https://github.com/FooStudio/tinycolor/blob/master/lib/tinycolor.dart)
extension ColorExtensions on Color {
  Color lighten({int amount: 10}) => _alter(amount: amount);

  Color darken({int amount: 10}) => _alter(amount: -amount);

  Color _alter({int amount}) {
    final hsl = HSLColor.fromColor(this);
    double l = hsl.lightness + (amount / 100);
    l = l.clamp(0.0, 1.0);
    double s = hsl.saturation;
    if (this.red == 0 && this.green == 0 && this.blue == 0) {
      // Special case for black, as lightening pure black makes red
      s = 0.0;
    }
    return hsl.withLightness(l).withSaturation(s).toColor();
  }
}

extension BuildContextExtensions on BuildContext {
  Color iconColor() {
    final theme = Theme.of(this);

    switch (theme.brightness) {
      case Brightness.light:
        return Colors.black87;
      default:
        return null;
    }
  }

  Color textColor() {
    final theme = Theme.of(this);

    switch (theme.brightness) {
      case Brightness.light:
        return Colors.black87;
      case Brightness.dark:
        return Colors.white70;
    }

    return null;
  }

  Color subtitleTextColor() {
    final theme = Theme.of(this);

    switch (theme.brightness) {
      case Brightness.light:
        return Colors.black54;
      case Brightness.dark:
        return Colors.white54;
    }

    return null;
  }

  TextStyle titleTextStyle({double fontSize: 16}) {
    final style = Theme.of(this).textTheme.subtitle1;
    final color = this.textColor();
    return style.copyWith(color: color, fontSize: fontSize);
  }

  TextStyle subtitleTextStyle({double fontSize: 12}) {
    final style = Theme.of(this).textTheme.bodyText1;
    final color = this.subtitleTextColor();
    return style.copyWith(color: color, fontSize: fontSize);
  }
}

extension IntToBoxFitExtensions on int {
  BoxFit toBoxFit() => BoxFit.values[this % BoxFit.values.length];
}

extension BoxFitExtensions on BoxFit {
  int toInt() => index;

  String getName() => toString().substringAfterLast('.');
}
