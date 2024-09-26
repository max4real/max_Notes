import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:get/get.dart';

class NoteCreateController extends GetxController {
  late DateTime createDate;
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
    super.onClose();
  }

  void storeContent() {
    final delta = quillController.value.document.toDelta();
    final jsonString = jsonEncode(delta.toJson());

    noteBody = jsonString;

    print('Stored Content: $noteBody');
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
      print("No content stored.");
    }
  }
}
