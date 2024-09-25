import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_notes/modules/home_page/v_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 1));
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
    ),
    home: const HomePage(),
  ));
}
