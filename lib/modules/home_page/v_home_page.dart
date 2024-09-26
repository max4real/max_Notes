import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:max_notes/_servies/theme_services/w_custon_theme_builder.dart';
import 'package:max_notes/models/m_note_model.dart';
import 'package:max_notes/modules/home_page/c_home_page.dart';
import 'package:get/get.dart';
import 'package:max_notes/modules/note_create/v_note_create.dart';
import 'package:max_notes/modules/note_edit/v_note_edit.dart';

import '../../_servies/data_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageController controller = Get.put(HomePageController());
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          backgroundColor: theme.background,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'max notes',
              style: TextStyle(color: theme.text1, fontSize: 17),
            ),
            backgroundColor: theme.background2,
            actions: [
              IconButton(
                  onPressed: () {
                    themeController.toggleTheme();
                  },
                  icon: Icon(
                    Icons.light_mode_rounded,
                    color: theme.text1,
                  ))
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(() => const NoteCreatePage())?.whenComplete(() async {
                await Future.delayed(const Duration(milliseconds: 500));
                controller.initLoad();
              });
            },
            backgroundColor: theme.secondary,
            child: const Icon(
              Icons.add,
              color: Color(0xFF1E1E1E),
              size: 30,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: ValueListenableBuilder(
              valueListenable: controller.xFetching,
              builder: (context, value, child) {
                if (value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: TextField(
                          controller: controller.txtSearchBar,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.done,
                          maxLines: 1,
                          onTapOutside: (event) {
                            dismissKeyboard();
                          },
                          style: TextStyle(color: theme.text1),
                          cursorColor: theme.text1,
                          cursorHeight: 18,
                          cursorWidth: 1.3,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.search_rounded,
                              color: Colors.grey,
                            ),
                            hintText: "Search",
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: theme.background2,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: controller.noteList,
                          builder: (context, value, child) {
                            if (value.isEmpty) {
                              return const Center(
                                child: Text("No Note Yet!"),
                              );
                            } else {
                              return MasonryGridView.count(
                                itemCount: value.length, //item count
                                crossAxisCount: 2, //colum count
                                mainAxisSpacing: 3,
                                crossAxisSpacing: 3,
                                itemBuilder: (context, index) {
                                  return Tile(
                                    index: index,
                                    eachNote: value[index],
                                    extent: (index % 5 + 1) * 100,
                                  );
                                },
                              );
                            }
                          },
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}

class Tile extends StatelessWidget {
  final int index;
  final double extent;
  final NoteModel eachNote;

  const Tile({
    required this.index,
    required this.extent,
    required this.eachNote,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomePageController controller = Get.find();
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return GestureDetector(
          onTap: () {
            Get.to(() => NoteEditPage(
                  eachNote: eachNote,
                ))?.whenComplete(() async {
              await Future.delayed(const Duration(milliseconds: 300));
              controller.initLoad();
            });
          },
          onLongPress: () {
            //Delete Code
            Get.defaultDialog(
              title: "Are you sure?",
              middleText:
                  "Do you really want to delete this Note?\nYou will not be able to undo this action.",
              backgroundColor: theme.background2,
              titleStyle: const TextStyle(color: Colors.black),
              middleTextStyle: const TextStyle(color: Colors.black),
              cancel: SizedBox(
                height: 40,
                width: 100,
                child: ElevatedButton(
                    onPressed: () {
                      controller.deleteNote(eachNote.id);
                    },
                    child: const Text(
                      "Delete",
                      style: TextStyle(color: Colors.redAccent),
                    )),
              ),
              confirm: SizedBox(
                height: 40,
                width: 100,
                child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Cancel")),
              ),
            );
          },
          child: Card(
            elevation: 4,
            color: theme.background2,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.getText(eachNote.noteBody),
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: theme.text1),
                  ),
                  Text(
                    controller.getText(eachNote.noteBody),
                    maxLines: 3,
                    style: TextStyle(fontSize: 13, color: theme.text1),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    controller.formatDate(eachNote.createDate
                        .add(const Duration(hours: 6, minutes: 30))),
                    style: TextStyle(fontSize: 12, color: theme.text1),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
