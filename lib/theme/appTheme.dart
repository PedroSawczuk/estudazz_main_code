import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:estudazz_main_code/services/theme/themeService.dart';

abstract final class AppTheme {
  static ThemeData lightTheme = FlexThemeData.light(
    scheme: FlexScheme.shadOrange,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );

  static ThemeData darkTheme = FlexThemeData.dark(
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

  static late ThemeService _themeService;
  static ThemeMode _currentThemeMode = ThemeMode.system;

  static Future<void> init() async {
    _themeService = ThemeService();
    _currentThemeMode = await _themeService.getSavedThemeMode();
  }

  static ThemeMode get currentThemeMode => _currentThemeMode;

  static set currentThemeMode(ThemeMode mode) {
    _currentThemeMode = mode;
    _themeService.saveThemeMode(mode);
  }
}
