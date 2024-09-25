import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_notes/_servies/theme_services/d_dark_theme.dart';
import 'package:max_notes/_servies/theme_services/d_light_theme.dart';
import 'package:max_notes/_servies/theme_services/m_theme_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum EnumAppTheme {
  light,
  dark,
}

class ThemeController extends GetxController {
  ValueNotifier<ThemeModel> currentTheme = ValueNotifier(LightThemeData.theme);
  final ValueNotifier<EnumAppTheme> _currentAppThemEnum =
      ValueNotifier(EnumAppTheme.dark);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  Future<void> initLoad() async {
    _currentAppThemEnum.addListener(() {
      updateTheme();
    });
    await Future.delayed(const Duration(microseconds: 10));
    try {
      SharedPreferences shareP = await SharedPreferences.getInstance();
      final saveTheme = shareP.getString("theme_key");
      if (saveTheme != null) {
        _currentAppThemEnum.value =
            EnumAppTheme.values.where((e) => e.name == saveTheme).firstOrNull ??
                EnumAppTheme.dark;
      }
    } catch (e) {
      //
    }
    await Future.delayed(const Duration(microseconds: 10));
    updateTheme();
  }

  void updateTheme() async {
    if (_currentAppThemEnum.value == EnumAppTheme.light) {
      currentTheme.value = LightThemeData.theme;
    } else {
      currentTheme.value = DarkThemData.theme;
    }
    SharedPreferences shareP = await SharedPreferences.getInstance();
    shareP.setString("theme_key", _currentAppThemEnum.value.name);
  }

  void setTheme({required EnumAppTheme enumAppTheme}) {
    _currentAppThemEnum.value = enumAppTheme;
  }

  void toggleTheme() {
    if (_currentAppThemEnum.value == EnumAppTheme.light) {
      _currentAppThemEnum.value = EnumAppTheme.dark;
    } else {
      _currentAppThemEnum.value = EnumAppTheme.light;
    }
  }

  bool xIsDarkTheme() {
    return _currentAppThemEnum.value == EnumAppTheme.dark;
  }
}

bool xIsDarkTheme() {
  ThemeController themeController = Get.find();
  return themeController.xIsDarkTheme();
}

T getThemeValue<T>({required T lightThemeValue, required T darkThemeValue}) {
  return xIsDarkTheme() ? darkThemeValue : lightThemeValue;
}
