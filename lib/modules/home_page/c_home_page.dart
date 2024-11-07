import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:max_notes/_servies/database_helper.dart';
import 'package:max_notes/models/m_text_body_model.dart';

import '../../models/m_note_model.dart';

class HomePageController extends GetxController {
  TextEditingController txtSearchBar = TextEditingController(text: "");
  ValueNotifier<List<NoteModel>> noteList = ValueNotifier([]);
  ValueNotifier<List<NoteModel>> noteFilterList = ValueNotifier([]);
  ValueNotifier<bool> xFetching = ValueNotifier(false);
  ValueNotifier<bool> themeSwitch = ValueNotifier(false);
  ValueNotifier<bool> selectMode = ValueNotifier(false);
  ValueNotifier<List<int>> selectedNoteList = ValueNotifier([]);

  final scrollController = ScrollController();
  final gridViewKey = GlobalKey();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  void initLoad() async {
    await Future.delayed(const Duration(milliseconds: 500));
    fetchNote();
  }

  void checkSelect(int index) {
    bool isSelected = selectedNoteList.value.contains(index);

    if (isSelected) {
      var temp = [...selectedNoteList.value];
      temp.remove(index);
      selectedNoteList.value = List.from(temp);
    } else {
      var temp = [...selectedNoteList.value];
      temp.add(index);
      selectedNoteList.value = List.from(temp);
    }
  }

//  [{id: 1, body: [{"insert":"hello\n"}], createdAt: 2024-11-06T17:08:21.517068},
//   {id: 2, body: [{"insert":"heyy\n"}], createdAt: 2024-11-06T17:08:51.399161},
//   {id: 3, body: [{"insert":"hi\n"}], createdAt: 2024-11-06T17:12:35.942892},
//   {id: 4, body: [{"insert":"hi\n"}], createdAt: 2024-11-06T17:12:56.512816}]
  Future<void> fetchNote() async {
    final dbHelper = DatabaseHelper();
    try {
      final response = await dbHelper.getItems();
      Iterable iterable = response;
      List<NoteModel> temp = [];
      for (var element in iterable) {
        NoteModel data = NoteModel.fromApi(data: element);
        temp.add(data);
      }
      temp.sort((a, b) => b.createDate.compareTo(a.createDate));
      noteList.value = temp;
      noteFilterList.value = noteList.value;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> deleteNote(String noteID) async {
    final dbHelper = DatabaseHelper();
    try {
      await dbHelper.deleteItem(int.parse(noteID));
    } catch (e) {
      print(e);
    }
  }

  void multiDelete() {
    Get.dialog(const Center(
      child: CircularProgressIndicator(),
    ));
    for (var index in selectedNoteList.value) {
      String id = noteList.value[index].id;
      deleteNote(id);
    }
    fetchNote();
    selectMode.value = false;
    Get.back();
  }

  List<TextBodyModel> getText(String data) {
    Iterable iterable = jsonDecode(data);
    List<TextBodyModel> temp = [];
    for (var element in iterable) {
      TextBodyModel rawData = TextBodyModel.fromJson(data: element);
      temp.add(rawData);
    }
    return temp;
  }

  String formatDate(DateTime rawDate) {
    if (getDate(rawDate) == getDate(DateTime.now())) {
      return "Today ${getTimeWithAmPm(rawDate)}";
    } else if (getDate(rawDate) ==
        getDate(DateTime.now().subtract(const Duration(days: 1)))) {
      return "Yesterday ${getTimeWithAmPm(rawDate)}";
    } else {
      return getFormattedDateTime(rawDate);
    }
  }

  String getDate(DateTime input) {
    return '${input.year}-${_twoDigits(input.month)}-${_twoDigits(input.day)}';
  }

  String getTimeWithAmPm(DateTime input) {
    return DateFormat('hh:mm a').format(input);
  }

  String getFormattedDateTime(DateTime input) {
    return DateFormat('MMM d hh:mma').format(input);
  }

  String _twoDigits(int n) {
    return n.toString().padLeft(2, '0');
  }

  ////----------Search------------////
  void searchGuest() {
    if (txtSearchBar.text.isNotEmpty) {
      filterByBody();
    } else {
      noteFilterList.value = noteList.value;
    }
  }

  void filterByBody() {
    List<NoteModel> temp = [];
    temp = noteList.value.where((test) {
      return test.noteBody.isCaseInsensitiveContains(txtSearchBar.text);
    }).toList();
    noteFilterList.value = temp;
  }
}
