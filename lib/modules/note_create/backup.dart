// import 'package:flutter/material.dart';
// import 'package:max_notes/_servies/data_controller.dart';
// import 'package:max_notes/_servies/theme_services/w_custon_theme_builder.dart';
// import 'package:max_notes/modules/note_create/c_note_create.dart';
// import 'package:get/get.dart';

// class NoteCreatePage extends StatelessWidget {
//   const NoteCreatePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     NoteCreateController controller = Get.put(NoteCreateController());
//     return MaxThemeBuilder(
//       builder: (context, theme, themeController) {
//         return Scaffold(
//           backgroundColor: theme.primaryAccent,
//           appBar: AppBar(
//             backgroundColor: theme.primaryAccent,
//             actions: [
//               IconButton(
//                 onPressed: () {
//                   if (controller.quillController.hasUndo) {
//                     controller.quillController.undo();
//                   }
//                 },
//                 icon: Icon(Icons.undo),
//               ),
//               // ValueListenableBuilder<UndoHistoryValue>(
//               //   valueListenable: controller.undoController,
//               //   builder: (BuildContext context, UndoHistoryValue value,
//               //       Widget? child) {
//               //     return Row(
//               //       children: <Widget>[
//               //         IconButton(
//               //           onPressed: () {
//               //             controller.undoController.undo();
//               //           },
//               //           icon: Icon(
//               //             Icons.undo_rounded,
//               //             color:
//               //                 value.canUndo ? Colors.deepPurple : Colors.grey,
//               //           ),
//               //         ),
//               //         IconButton(
//               //           onPressed: () {
//               //             controller.undoController.redo();
//               //           },
//               //           icon: Icon(
//               //             Icons.redo_rounded,
//               //             color:
//               //                 value.canRedo ? Colors.deepPurple : Colors.grey,
//               //           ),
//               //         )
//               //       ],
//               //     );
//               //   },
//               // ),
//             ],
//           ),
//           body: Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20),
//             child: Stack(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       myDateFormat(controller.createDate),
//                     ),
//                     Expanded(
//                       child: TextField(
//                         controller: controller.txtData,
//                         focusNode: controller.focusNode,
//                         undoController: controller.undoController,
//                         showCursor: true,
//                         autofocus: true,
//                         maxLines: null,
//                         keyboardType: TextInputType.multiline,
//                         cursorColor: Colors.deepPurple,
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         color: theme.onBackground,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       margin: const EdgeInsets.only(
//                         left: 15,
//                         right: 15,
//                         bottom: 15,
//                       ),
//                       height: 40,
//                       child: ValueListenableBuilder(
//                         valueListenable: controller.index_,
//                         builder: (context, value, child) {
//                           return Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               IconButton(
//                                 isSelected: value == 0 ? true : false,
//                                 onPressed: () {
//                                   controller.index_.value = 0;
//                                 },
//                                 icon: const Icon(
//                                   Icons.format_italic_rounded,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                               IconButton(
//                                 isSelected: value == 1 ? true : false,
//                                 onPressed: () {
//                                   controller.index_.value = 1;
//                                 },
//                                 icon: const Icon(
//                                   Icons.format_bold_rounded,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                               IconButton(
//                                 isSelected: value == 2 ? true : false,
//                                 onPressed: () {
//                                   controller.index_.value = 2;
//                                 },
//                                 icon: const Icon(
//                                   Icons.format_underlined_rounded,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                               IconButton(
//                                 isSelected: value == 3 ? true : false,
//                                 onPressed: () {
//                                   controller.index_.value = 3;
//                                 },
//                                 icon: const Icon(
//                                   Icons.format_align_center_rounded,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
