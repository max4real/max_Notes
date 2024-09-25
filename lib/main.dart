import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_notes/_servies/theme_services/c_theme_controller.dart';
import 'package:max_notes/modules/home_page/v_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 1));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    injectDependencies();
    // ThemeController themeController = Get.find();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'max notes',
      useInheritedMediaQuery: true,
      locale: const Locale('en', 'EN'),
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData(
        useMaterial3: true,
        // primarySwatch: MaterialColor(
        //     themeController.currentTheme.value.primary.value, const {
        //   050: Color.fromRGBO(29, 44, 77, .1),
        //   100: Color.fromRGBO(29, 44, 77, .2),
        //   200: Color.fromRGBO(29, 44, 77, .3),
        //   300: Color.fromRGBO(29, 44, 77, .4),
        //   400: Color.fromRGBO(29, 44, 77, .5),
        //   500: Color.fromRGBO(29, 44, 77, .6),
        //   600: Color.fromRGBO(29, 44, 77, .7),
        //   700: Color.fromRGBO(29, 44, 77, .8),
        //   800: Color.fromRGBO(29, 44, 77, .9),
        //   900: Color.fromRGBO(29, 44, 77, 1),
        // }),
        // fontFamily: 'Nunito',
        // fontFamilyFallback: const ['Book'],
        // textTheme: TextTheme(
        //   bodyMedium: AppConstants.defaultTextStyle,
        //   titleMedium: AppConstants.defaultTextStyle,
        //   labelLarge: AppConstants.defaultTextStyle,
        //   bodyLarge: AppConstants.defaultTextStyle,
        //   bodySmall: AppConstants.defaultTextStyle,
        //   titleLarge: AppConstants.defaultTextStyle,
        //   titleSmall: AppConstants.defaultTextStyle,
        // ),
      ),
      home: const HomePage(),
    );
  }

  void injectDependencies() {
    Get.put(ThemeController());
  }
}
