import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:max_notes/_servies/data_controller.dart';

class NoteCreateController extends GetxController {
  late DateTime createDate;
  TextEditingController txtData = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final UndoHistoryController undoController = UndoHistoryController();

  ValueNotifier<int> index_ = ValueNotifier(0);

  final QuillController quillController = QuillController.basic();

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
    print("Data : " + txtData.text);
    print('_____________________________');
    print(myDateFormat(createDate));
  }

  // Toggle Bold text
  void toggleBold() {
    var currentAttributes = quillController.getSelectionStyle().attributes;
    if (currentAttributes.containsKey(Attribute.bold.key)) {
      quillController.formatSelection(
          Attribute.clone(Attribute.bold, null)); // Remove Bold
    } else {
      quillController.formatSelection(Attribute.bold); // Apply Bold
    }
  }

  // Toggle Italic text
  void toggleItalic() {
    var currentAttributes = quillController.getSelectionStyle().attributes;
    if (currentAttributes.containsKey(Attribute.italic.key)) {
      quillController.formatSelection(
          Attribute.clone(Attribute.italic, null)); // Remove Italic
    } else {
      quillController.formatSelection(Attribute.italic); // Apply Italic
    }
  }
}
