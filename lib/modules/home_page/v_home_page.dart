import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:max_notes/_servies/theme_services/w_custon_theme_builder.dart';
import 'package:max_notes/modules/home_page/c_home_page.dart';
import 'package:get/get.dart';

import '../../_servies/data_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageController controller = Get.put(HomePageController());
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'max notes',
              style: TextStyle(color: theme.text1, fontSize: 17),
            ),
            backgroundColor: theme.secondary,
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
            onPressed: () {},
            backgroundColor: theme.secondary,
            child: Icon(
              Icons.add,
              color: theme.text1,
              size: 30,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: TextField(
                    controller: controller.txtSearchBar,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                    maxLines: 1,
                    onTapOutside: (event) {
                      dismissKeyboard();
                    },
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: theme.primaryAccent,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15.0),
                    ),
                  ),
                ),
                Expanded(
                  child: MasonryGridView.count(
                    crossAxisCount: 2, //colum count
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    itemCount: 10, //item count
                    itemBuilder: (context, index) {
                      return Tile(
                        index: index,
                        extent: (index % 5 + 1) * 100,
                      );
                    },
                  ),
                )
              ],
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
  final String? customText;

  const Tile({
    required this.index,
    required this.extent,
    this.customText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return SizedBox(
          height: extent,
          child: Card(
            color: theme.secondary,
            child: Center(
              child: Text(
                customText ?? 'Tile $index' + '\nextent' + extent.toString(),
              ),
            ),
          ),
        );
      },
    );
  }
}
