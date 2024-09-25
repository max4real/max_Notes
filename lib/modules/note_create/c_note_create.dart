import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_notes/_servies/data_controller.dart';

class NoteCreateController extends GetxController {
  late DateTime createDate;
  TextEditingController txtData = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final UndoHistoryController undoController = UndoHistoryController();

  ValueNotifier<int> index_ = ValueNotifier(0);

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
  
}
