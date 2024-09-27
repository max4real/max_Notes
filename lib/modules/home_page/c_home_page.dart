import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:max_notes/_servies/api_endpoint.dart';
import 'package:max_notes/models/m_text_body_model.dart';

import '../../models/m_note_model.dart';

class HomePageController extends GetxController {
  TextEditingController txtSearchBar = TextEditingController(text: "");
  ValueNotifier<List<NoteModel>> noteList = ValueNotifier([]);
  ValueNotifier<bool> xFetching = ValueNotifier(false);
  ValueNotifier<bool> themeSwitch = ValueNotifier(false);
  ValueNotifier<bool> selectMode = ValueNotifier(false);
  ValueNotifier<List<int>> selectedNoteList = ValueNotifier([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  void initLoad() async {
    await Future.delayed(const Duration(seconds: 1));
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

  Future<void> fetchNote() async {
    String url = ApiEndpoint().baseUrl + ApiEndpoint().noteUrl;
    GetConnect client = GetConnect(timeout: const Duration(seconds: 10));
    xFetching.value = true;

    try {
      final response = await client.get(url);
      xFetching.value = false;

      if (response.isOk) {
        Iterable iterable = response.body["_data"] ?? [];
        List<NoteModel> temp = [];
        for (var element in iterable) {
          NoteModel data = NoteModel.fromApi(data: element);
          temp.add(data);
        }
        temp.sort((a, b) => b.createDate.compareTo(a.createDate));
        noteList.value = temp;
      } else {
        String errMessage = response.body["_metadata"]["message"].toString();
        Get.snackbar("Error", errMessage);
      }
    } catch (e) {}
  }

  Future<void> deleteNote(String noteID) async {
    String url = "${ApiEndpoint().baseUrl}${ApiEndpoint().noteUrl}/$noteID";
    GetConnect client = GetConnect(timeout: const Duration(seconds: 10));
    try {
      final response = await client.delete(url);
      if (response.isOk) {
        Get.back();
        fetchNote();
        // String errMessage = response.body["_metadata"]["message"].toString();
        // Get.snackbar("Successfull", errMessage);
      } else {
        String errMessage = response.body["_metadata"]["message"].toString();
        Get.snackbar("Error", errMessage);
      }
    } catch (e) {}
  }

  void multiDelete() {
    Get.dialog(const Center(
      child: CircularProgressIndicator(),
    ));
    for (var index in selectedNoteList.value) {
      String id = noteList.value[index].id;
      deleteNote(id);
    }
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
}
