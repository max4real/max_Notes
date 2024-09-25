import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataController extends GetxController {}

void dismissKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}
