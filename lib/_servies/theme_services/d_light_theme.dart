import 'package:flutter/material.dart';
import 'package:max_notes/_servies/theme_services/m_theme_model.dart';

Color primary = const Color(0XFFF2F2F2);
Color primaryAccent = const Color(0XFFB0B0B0);
Color secondary = const Color(0XFFCAF477);

Color background = const Color(0XFFF0F0F0);
Color background2 = const Color(0XFFFFFFFF);
Color onBackground = const Color.fromARGB(255, 219, 218, 218);

Color text1 = const Color(0xFF2B2B2B);

// for search bar light #B0B0B0 
class LightThemeData {
  static ThemeModel theme = ThemeModel(
      primary: primary,
      primaryAccent: primaryAccent,
      secondary: secondary,
      background: background,
      background2: background2,
      onBackground: onBackground,
      text1: text1);
}
