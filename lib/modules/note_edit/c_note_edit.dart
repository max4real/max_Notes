import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:get/get.dart';

import '../../_servies/api_endpoint.dart';

class NoteEditController extends GetxController {
  late String noteID;
  late DateTime createDate;

  ValueNotifier<QuillController> quillController =
      ValueNotifier(QuillController.basic());
  ValueNotifier<bool> xFecthing = ValueNotifier(false);

  String noteBody = "";
  String sotreNoteBody = "";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    checkForNull();
  }

  void checkForNull() {
    if (quillController.value.document.isEmpty()) {
      deleteNote();
    } else {
      storeContent();
    }
  }

  void storeContent() {
    final delta = quillController.value.document.toDelta();
    final jsonString = jsonEncode(delta.toJson());

    noteBody = jsonString;
    if (sotreNoteBody == noteBody) {
      //do nothing
    } else {
      patchNote();
    }
  }

  Future<void> patchNote() async {
    String url = "${ApiEndpoint().baseUrl}${ApiEndpoint().noteUrl}/$noteID";
    GetConnect client = GetConnect(timeout: const Duration(seconds: 10));

    xFecthing.value = true;
    // Get.dialog(const Center(
    //   child: CircularProgressIndicator(),
    // ));
    try {
      final response = await client.patch(url, {"text": noteBody.toString()});
      xFecthing.value = false;
      // Get.back();
      if (response.isOk) {
        // String errMessage = response.body["_metadata"]["message"].toString();
        // Get.snackbar("Successfull", errMessage);
      } else {
        String errMessage = response.body["_metadata"]["message"].toString();
        Get.snackbar("Error", errMessage);
      }
    } catch (e) {}
  }

  Future<void> deleteNote() async {
    String url = "${ApiEndpoint().baseUrl}${ApiEndpoint().noteUrl}/$noteID";
    GetConnect client = GetConnect(timeout: const Duration(seconds: 10));
    try {
      final response = await client.delete(url);
      if (response.isOk) {
        // String errMessage = response.body["_metadata"]["message"].toString();
        // Get.snackbar("Successfull", errMessage);
      } else {
        String errMessage = response.body["_metadata"]["message"].toString();
        Get.snackbar("Error", errMessage);
      }
    } catch (e) {}
  }

  void loadContent(String noteBody) {
    sotreNoteBody = noteBody;
    if (noteBody.isNotEmpty) {
      final deltaJson = jsonDecode(noteBody);
      final delta = Delta.fromJson(deltaJson);

      quillController.value = QuillController(
        document: Document.fromDelta(delta), // Load document from Delta
        selection: const TextSelection.collapsed(
          offset: 0,
        ), // Reset the cursor position
      );
    } else {
      // print("No content stored.");
    }
  }
}
