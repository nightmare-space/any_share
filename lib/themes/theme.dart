import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_repository/global_repository.dart';

export 'theme_dark.dart';
export 'theme_light.dart';

FontWeight? bold = GetPlatform.isLinux ? null : FontWeight.bold;

extension ThemeExt on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

extension ThemeStateExt on State {
  ColorScheme get colorScheme => Theme.of(context).colorScheme;
}

extension ColorSchemeExt on ColorScheme {
  Color get surface1 => primary.withOpacityExact(0.05);
  Color get surface2 => primary.withOpacityExact(0.08);
  Color get surface3 => primary.withOpacityExact(0.11);
  Color get surface4 => primary.withOpacityExact(0.12);
}

const seed = Color(0xff6A6DED);
