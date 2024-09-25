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
          backgroundColor: theme.primaryAccent,
          appBar: AppBar(
            backgroundColor: theme.primaryAccent,
            actions: [
              IconButton(
                onPressed: () {
                  if (controller.quillController.hasUndo) {
                    controller.quillController.undo();
                  }
                },
                icon: const Icon(Icons.undo_rounded),
              ),
              IconButton(
                onPressed: () {
                  if (controller.quillController.hasRedo) {
                    controller.quillController.redo();
                  }
                },
                icon: const Icon(Icons.redo_rounded),
              ),
              IconButton(
                onPressed: () {
                  controller.toggleBold();
                },
                icon: const Icon(Icons.format_bold),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  myDateFormat(controller.createDate),
                ),
                Expanded(
                  child: QuillEditor.basic(
                    controller: controller.quillController,
                  ),
                ),
                QuillToolbar.simple(
                  controller: controller.quillController,
                  configurations: const QuillSimpleToolbarConfigurations(
                      toolbarSectionSpacing: 0,
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
                      showColorButton: false,
                      showBackgroundColorButton: false,
                      showClearFormat: false,
                      showHeaderStyle: false,
                      showCodeBlock: false,
                      showQuote: false,
                      showLink: false,
                      showSearchButton: false,
                      showClipboardCut: false,
                      showClipboardCopy: false,
                      showClipboardPaste: false),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
