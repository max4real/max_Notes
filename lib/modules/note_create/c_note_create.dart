import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

import '../../_servies/database_helper.dart';

class NoteCreateController extends GetxController {
  late DateTime createDate;
  String noteBody = "";

  ValueNotifier<bool> xFecthing = ValueNotifier(false);
  ValueNotifier<QuillController> quillController =
      ValueNotifier(QuillController.basic());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  void initLoad() {
    createDate = DateTime.now();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    storeContent();
    super.onClose();
  }

  void storeContent() {
    final delta = quillController.value.document.toDelta();
    final jsonString = jsonEncode(delta.toJson());

    noteBody = jsonString;
    saveNote();
  }

  Future<void> saveNote() async {
    final dbHelper = DatabaseHelper();

    if (quillController.value.document.isEmpty()) {
      //do nothing
    } else {
      try {
        await dbHelper.insertItem(
            body: noteBody, createdAt: DateTime.now().toIso8601String());
        print("Item inserted successfully!");
      } catch (e) {
        Get.snackbar("Error", e.toString());
      }
    }
    // String url = ApiEndpoint().baseUrl + ApiEndpoint().noteUrl;
    // GetConnect client = GetConnect(timeout: const Duration(seconds: 10));

    // if (quillController.value.document.isEmpty()) {
    // } else {
    //   xFecthing.value = true;
    //   // Get.dialog(const Center(
    //   //   child: CircularProgressIndicator(),
    //   // ));
    //   try {
    //     final response = await client.post(url, {"text": noteBody.toString()});
    //     xFecthing.value = false;
    //     // Get.back();
    //     if (response.isOk) {
    //       // String errMessage = response.body["_metadata"]["message"].toString();
    //       // Get.snackbar("Successfull", errMessage);
    //     } else {
    //       String errMessage = response.body["_metadata"]["message"].toString();
    //       Get.snackbar("Error", errMessage);
    //     }
    //   } catch (e) {}
    // }
  }
}
