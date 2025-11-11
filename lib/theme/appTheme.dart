import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final ThemeData darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.shadOrange,
  subThemesData: const FlexSubThemesData(
    interactionEffects: true,
    tintedDisabledControls: true,
    blendOnColors: true,
    useM2StyleDividerInM3: true,
    inputDecoratorIsFilled: true,
    inputDecoratorBorderType: FlexInputBorderType.outline,
    alignedDropdown: true,
    navigationRailUseIndicator: true,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
);
