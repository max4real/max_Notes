import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/widgets/widgets.dart';
import 'package:max_notes/_servies/theme_services/d_light_theme.dart';

class MyApp2 extends StatefulWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp2> {
  final _scrollController = ScrollController();
  final _gridViewKey = GlobalKey();

  var _fruits = <String>[
    "apple",
    "banana",
    "strawberry",
    '1',
    "2",
    "3",
    "4",
    "5",
    "6"
  ];

  @override
  Widget build(BuildContext context) {
    final generatedChildren = List.generate(
      _fruits.length,
      (index) {
        return Card(
          elevation: 2,
          key: Key(_fruits.elementAt(index)),
          color: background,
          child: Center(
            child: Text(
                // _fruits.elementAt(index),
                _fruits[index]),
          ),
        );
        // return Card(
        //   child: Container(
        //     key: Key(_fruits.elementAt(index)),
        //     child: Text(
        //         // _fruits.elementAt(index),
        //         _fruits[index]),
        //   ),
        // );
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          ElevatedButton(
            onPressed: () {
              // _fruits.forEach(print);
              print(_fruits.elementAt(0));
              print(_fruits[0]);
            },
            child: Text("Print"),
          )
        ],
      ),
      body: ReorderableBuilder(
        children: generatedChildren,
        scrollController: _scrollController,
        onReorder: (ReorderedListFunction reorderedListFunction) {
          setState(() {
            _fruits = reorderedListFunction(_fruits) as List<String>;
          });
        },
        builder: (children) {
          return GridView(
            key: _gridViewKey,
            controller: _scrollController,
            children: children,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 8,
            ),
          );
        },
      ),
    );
  }
}
