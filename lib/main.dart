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
      ),
      home: const HomePage(),
    );
  }

  void injectDependencies() {
    Get.put(ThemeController());
  }
}
