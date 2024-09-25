import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:max_notes/_servies/theme_services/c_theme_controller.dart';
import 'package:max_notes/_servies/theme_services/m_theme_model.dart';

class MaxThemeBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ThemeModel theme,
      ThemeController themeController) builder;
  final bool xRefreshSystemUiOverlay;

  const MaxThemeBuilder(
      {super.key, required this.builder, this.xRefreshSystemUiOverlay = true});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return ValueListenableBuilder(
          valueListenable: themeController.currentTheme,
          builder: (context, theme, child) {
            if (xRefreshSystemUiOverlay) {
              SystemChrome.setSystemUIOverlayStyle(
                  themeController.xIsDarkTheme()
                      ? SystemUiOverlayStyle.dark
                      : SystemUiOverlayStyle.light);
            }
            return builder(context, theme, themeController);
          },
        );
      },
    );
  }
}
