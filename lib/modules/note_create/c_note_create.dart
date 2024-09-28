import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:get/get.dart';
import 'package:max_notes/_servies/api_endpoint.dart';

class NoteCreateController extends GetxController {
  late DateTime createDate;
  ValueNotifier<bool> xFecthing = ValueNotifier(false);
  ValueNotifier<QuillController> quillController =
      ValueNotifier(QuillController.basic());

  String noteBody = "";

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
    fetchNote();
  }

  Future<void> fetchNote() async {
    String url = ApiEndpoint().baseUrl + ApiEndpoint().noteUrl;
    GetConnect client = GetConnect(timeout: const Duration(seconds: 10));

    if (quillController.value.document.isEmpty()) {
    } else {
      xFecthing.value = true;
      // Get.dialog(const Center(
      //   child: CircularProgressIndicator(),
      // ));
      try {
        final response = await client.post(url, {"text": noteBody.toString()});
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
  }

  void loadContent() {
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
