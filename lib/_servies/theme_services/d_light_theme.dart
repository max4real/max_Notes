import 'package:flutter/material.dart';
import 'package:max_notes/_servies/theme_services/m_theme_model.dart';

Color primary = const Color(0XFFF2F2F2);
Color secondary = const Color(0XFFCAF477);
Color background = const Color(0xFF151515);
Color background2 = const Color(0xFF1A1A1A);
Color onBackground = const Color(0xFF252525);
Color text1 = const Color(0xFF252525);
Color navi1 = const Color(0XFFEDB8A7);
Color navi2 = const Color(0XFFA7EDED);
Color navi3 = const Color(0XFFADA7ED);
Color navi4 = const Color.fromARGB(255, 99, 136, 211);
Color navi5 = const Color(0XFFD1E3F6);

class LightThemeData {
  static ThemeModel theme = ThemeModel(
    primary: primary,
    primaryAccent: primary,
    secondary: secondary,
    background: background,
    background2: background2,
    onBackground: onBackground,
    text1:text1
  );
}
