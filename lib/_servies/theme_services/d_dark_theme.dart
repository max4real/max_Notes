import 'package:flutter/material.dart';
import 'package:max_notes/_servies/theme_services/m_theme_model.dart';

Color primary = const Color(0XFFF2F2F2);
Color primaryAccent = const Color.fromARGB(255, 232, 231, 229);
Color secondary = const Color.fromARGB(255, 116, 133, 82);
Color background = const Color(0xFF151515);
// Color background2 = const Color(0xFF1A1A1A);
Color background2 = const Color(0xFFEAE8D2);

Color onBackground = const Color(0xFF252525);
Color text1 = const Color(0xFFFFFFFF);

Color navi1 = const Color(0XFFEDB8A7);
Color navi2 = const Color(0XFFA7EDED);
Color navi3 = const Color(0XFFADA7ED);
Color navi4 = const Color.fromARGB(255, 99, 136, 211);
Color navi5 = const Color(0XFFD1E3F6);

class DarkThemData {
  static ThemeModel theme = ThemeModel(
    primary: primary,
    primaryAccent: primaryAccent,
    secondary: secondary,
    background: background,
    background2: background2,
    onBackground: onBackground,
    text1: text1,
  );
}
