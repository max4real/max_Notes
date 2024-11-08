import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:max_notes/_servies/theme_services/w_custon_theme_builder.dart';
import 'package:max_notes/models/m_note_model.dart';
import 'package:max_notes/models/m_text_body_model.dart';
import 'package:max_notes/modules/home_page/c_home_page.dart';
import 'package:get/get.dart';
import 'package:max_notes/modules/note_create/v_note_create.dart';
import 'package:max_notes/modules/note_edit/v_note_edit.dart';

import '../../_servies/data_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            leading: ValueListenableBuilder(
              valueListenable: controller.selectMode,
              builder: (context, value, child) {
                return IconButton(
                  onPressed: () {
                    controller.selectMode.value = !value;
                    controller.selectedNoteList.value.clear();
                  },
                  icon: Icon(
                      value ? Icons.delete_forever_rounded : Icons.delete,
                      color: value ? Colors.redAccent : Colors.grey),
                );
              },
            ),
            actions: [
              ValueListenableBuilder(
                valueListenable: controller.themeSwitch,
                builder: (context, value, child) {
                  return Switch(
                      thumbIcon: MaterialStateProperty.all<Icon>(
                          const Icon(Icons.dark_mode_rounded)),
                      value: value,
                      onChanged: (value) {
                        controller.themeSwitch.value = value;
                        themeController.toggleTheme();
                      },
                      activeColor:
                          theme.onBackground, // Color when the switch is ON
                      inactiveThumbColor: const Color.fromARGB(
                          255, 58, 58, 58), // Color when the switch is OFF
                      inactiveTrackColor: theme.background2);
                },
              )
            ],
          ),
          floatingActionButton: ValueListenableBuilder(
            valueListenable: controller.selectMode,
            builder: (context, mode, child) {
              return Visibility(
                visible: !mode,
                child: FloatingActionButton(
                  onPressed: () {
                    Get.to(() => const NoteCreatePage())?.whenComplete(() {
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
              );
            },
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: ValueListenableBuilder(
              valueListenable: controller.selectMode,
              builder: (context, mode, child) {
                return Stack(
                  children: [
                    Column(
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
                            onChanged: (value) {
                              controller.searchGuest();
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
                              hintText: "Search Note",
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
                            valueListenable: controller.noteFilterList,
                            builder: (context, value, child) {
                              if (value.isEmpty) {
                                return Center(
                                  child: Text(
                                    "No Note Yet!",
                                    style: TextStyle(color: theme.text1),
                                  ),
                                );
                              } else {
                                final generatedChildren = List.generate(
                                  controller.noteFilterList.value.length,
                                  (index) {
                                    return Tile(
                                      key: Key(controller.noteFilterList.value
                                          .elementAt(index)
                                          .id),
                                      index: index,
                                      eachNote: value[index],
                                      extent: (index % 5 + 1) * 100,
                                    );
                                  },
                                );
                                return RefreshIndicator(
                                  onRefresh: () {
                                    return controller.fetchNote();
                                  },
                                  child: ReorderableBuilder(
                                    children: generatedChildren,
                                    scrollController:
                                        controller.scrollController,
                                    feedbackScaleFactor: 1,
                                    onReorder: (ReorderedListFunction
                                        reorderedListFunction) {
                                      setState(() {
                                        controller.noteFilterList
                                            .value = reorderedListFunction(
                                                controller.noteFilterList.value)
                                            as List<NoteModel>;
                                      });
                                    },
                                    builder: (children) {
                                      return MasonryGridView(
                                        key: controller.gridViewKey,
                                        controller: controller.scrollController,
                                        children: children,
                                        gridDelegate:
                                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                        ),
                                      );
                                      // return GridView(
                                      //   key: controller.gridViewKey,
                                      //   controller: controller.scrollController,
                                      //   children: children,
                                      //   gridDelegate:
                                      //       const SliverGridDelegateWithFixedCrossAxisCount(
                                      //         childAspectRatio: 1*0.9,
                                      //     crossAxisCount: 2,
                                      //     mainAxisSpacing: 4,
                                      //     crossAxisSpacing: 4,
                                      //   ),
                                      // );
                                    },
                                  ),
                                  // child: MasonryGridView.count(
                                  //   physics:
                                  //       const AlwaysScrollableScrollPhysics(),
                                  //   itemCount: value.length, //item count
                                  //   crossAxisCount: 2, //colum count
                                  //   mainAxisSpacing: 3,
                                  //   crossAxisSpacing: 3,
                                  //   itemBuilder: (context, index) {
                                  //     return Tile(
                                  //       index: index,
                                  //       eachNote: value[index],
                                  //       extent: (index % 5 + 1) * 100,
                                  //     );
                                  //   },
                                  // ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: mode,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FloatingActionButton(
                          onPressed: () {
                            controller.multiDelete();
                          },
                          backgroundColor: Colors.redAccent,
                          child: const Icon(
                            Icons.delete_forever_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    )
                  ],
                );
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
    String strHeader = "";
    String strbody = "";

    List<TextBodyModel> data = controller.getText(eachNote.noteBody);

    if (data.length > 1) {
      strHeader = data[0].text;
      strbody = data[1].text;
    } else {
      strHeader = data[0].text;
    }

    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return ValueListenableBuilder(
          valueListenable: controller.selectMode,
          builder: (context, mode, child) {
            return GestureDetector(
              onTap: () {
                if (mode) {
                  controller.checkSelect(index);
                } else {
                  Get.to(() => NoteEditPage(
                        eachNote: eachNote,
                      ))?.whenComplete(() async {
                    await Future.delayed(const Duration(milliseconds: 300));
                    controller.initLoad();
                  });
                }
              },
              child: ValueListenableBuilder(
                valueListenable: controller.selectedNoteList,
                builder: (context, value, child) {
                  bool isSelected = value.contains(index);
                  return Card(
                    shadowColor: theme.background,
                    elevation: 4,
                    color: theme.background2,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                strHeader,
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: theme.text1),
                              ),
                              Text(
                                strbody,
                                maxLines: 3,
                                style:
                                    TextStyle(fontSize: 13, color: theme.text1),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      controller
                                          .formatDate(eachNote.createDate),
                                      style: TextStyle(
                                          fontSize: 12, color: theme.text1),
                                    ),
                                  ),
                                  Visibility(
                                    visible: mode,
                                    child: Icon(
                                      isSelected
                                          ? Icons.check_box_rounded
                                          : Icons
                                              .check_box_outline_blank_rounded,
                                      color: theme.text1,
                                      size: 17,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
