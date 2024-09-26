import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:max_notes/_servies/data_controller.dart';
import 'package:max_notes/_servies/theme_services/w_custon_theme_builder.dart';
import 'package:max_notes/modules/note_create/c_note_create.dart';
import 'package:get/get.dart';

class NoteCreatePage extends StatelessWidget {
  const NoteCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    NoteCreateController controller = Get.put(NoteCreateController());
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          backgroundColor: theme.onBackground,
          appBar: AppBar(
            backgroundColor: theme.onBackground,
            // iconTheme: IconThemeData(
            //   color: theme.text1,
            // ),
            actions: [
              IconButton(
                onPressed: () {
                  if (controller.quillController.value.hasUndo) {
                    controller.quillController.value.undo();
                  }
                },
                icon: const Icon(
                  Icons.undo_rounded,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (controller.quillController.value.hasRedo) {
                    controller.quillController.value.redo();
                  }
                },
                icon: const Icon(
                  Icons.redo_rounded,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    myDateFormat(controller.createDate),
                  ),
                ),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: controller.quillController,
                    builder: (context, value, child) {
                      return QuillEditor.basic(
                        controller: controller.quillController.value,
                      );
                    },
                  ),
                ),
                QuillToolbar.simple(
                  controller: controller.quillController.value,
                  configurations: QuillSimpleToolbarConfigurations(
                    color: Colors.amberAccent,
                    customButtons: [
                      QuillToolbarCustomButtonOptions(
                        tooltip: 'Show Format List',
                        icon: const Icon(Icons.format_list_bulleted_rounded),
                        onPressed: () {
                          showFormatList();
                        },
                      ),
                      QuillToolbarCustomButtonOptions(
                        tooltip: 'Show Indent',
                        icon: const Icon(Icons.format_indent_increase_rounded),
                        onPressed: () {
                          showIndent();
                        },
                      ),
                    ],
                    toolbarSectionSpacing: 0,
                    showIndent: false,
                    showListBullets: false,
                    showListCheck: false,
                    showListNumbers: false,
                    showRedo: false,
                    showUndo: false,
                    showDividers: false,
                    showFontFamily: false,
                    showFontSize: false,
                    showStrikeThrough: false,
                    showInlineCode: false,
                    showSubscript: false,
                    showSuperscript: false,
                    showSmallButton: false,
                    showBackgroundColorButton: false,
                    showClearFormat: false,
                    showHeaderStyle: false,
                    showCodeBlock: false,
                    showQuote: false,
                    showLink: false,
                    showSearchButton: false,
                    showClipboardCut: false,
                    showClipboardCopy: false,
                    showClipboardPaste: false,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showFormatList() {
    NoteCreateController controller = Get.find();
    Get.bottomSheet(
      MaxThemeBuilder(
        builder: (context, theme, themeController) {
          return Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.background2,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Select Format",
                        style: TextStyle(color: theme.text1, fontSize: 18),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: theme.text1,
                        ),
                      )
                    ],
                  ),
                  QuillToolbar.simple(
                    controller: controller.quillController.value,
                    configurations: const QuillSimpleToolbarConfigurations(
                      toolbarSectionSpacing: 10,
                      showIndent: false,
                      // showListBullets: false,
                      // showListCheck: false,
                      // showListNumbers: false,
                      showBoldButton: false,
                      showItalicButton: false,
                      showUnderLineButton: false,
                      showColorButton: false,
                      showRedo: false,
                      showUndo: false,
                      showDividers: false,
                      showFontFamily: false,
                      showFontSize: false,
                      showStrikeThrough: false,
                      showInlineCode: false,
                      showSubscript: false,
                      showSuperscript: false,
                      showSmallButton: false,
                      showBackgroundColorButton: false,
                      showClearFormat: false,
                      showHeaderStyle: false,
                      showCodeBlock: false,
                      showQuote: false,
                      showLink: false,
                      showSearchButton: false,
                      showClipboardCut: false,
                      showClipboardCopy: false,
                      showClipboardPaste: false,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void showIndent() {
    NoteCreateController controller = Get.find();
    Get.bottomSheet(
      MaxThemeBuilder(
        builder: (context, theme, themeController) {
          return Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.background2,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Select Indent",
                        style: TextStyle(color: theme.text1, fontSize: 18),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: theme.text1,
                        ),
                      )
                    ],
                  ),
                  QuillToolbar.simple(
                    controller: controller.quillController.value,
                    configurations: const QuillSimpleToolbarConfigurations(
                      toolbarSectionSpacing: 10,
                      showListBullets: false,
                      showListCheck: false,
                      showListNumbers: false,
                      showBoldButton: false,
                      showItalicButton: false,
                      showUnderLineButton: false,
                      showColorButton: false,
                      showRedo: false,
                      showUndo: false,
                      showDividers: false,
                      showFontFamily: false,
                      showFontSize: false,
                      showStrikeThrough: false,
                      showInlineCode: false,
                      showSubscript: false,
                      showSuperscript: false,
                      showSmallButton: false,
                      showBackgroundColorButton: false,
                      showClearFormat: false,
                      showHeaderStyle: false,
                      showLink: false,
                      showSearchButton: false,
                      showClipboardCut: false,
                      showClipboardCopy: false,
                      showClipboardPaste: false,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
