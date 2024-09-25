import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/flutter_quill.dart';

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuillEditorPage(),
    );
  }
}

class QuillEditorPage extends StatefulWidget {
  @override
  _QuillEditorPageState createState() => _QuillEditorPageState();
}

class _QuillEditorPageState extends State<QuillEditorPage> {
  final QuillController _controller = QuillController.basic();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rich Text Editor with Bold'),
        actions: [
          IconButton(
            onPressed: () {
              if (_controller.hasUndo) {
                _controller.undo();
              }
            },
            icon: Icon(Icons.undo),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            // QuillEditor widget for text editing
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: QuillEditor.basic(
                controller: _controller,
                // : false, // Make it interactive
              ),
            ),
          ),
          Container(
            // color: Colors.amber,
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: QuillToolbar.simple(
              controller: _controller,
              configurations: const QuillSimpleToolbarConfigurations(
                  toolbarSectionSpacing: 0,
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
                  // showClearFormat: false,
                  showHeaderStyle: false,
                  showCodeBlock: false,
                  showQuote: false,
                  showLink: false,
                  showSearchButton: false,
                  showClipboardCut: false,
                  showClipboardCopy: false,
                  showClipboardPaste: false),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Apply bold formatting to the selected text
              _toggleBold();
              print(_controller.document.toDelta());
            },
            child: Text('Make Selected Text Bold'),
          ),
        ],
      ),
    );
  }

  void _toggleBold() {
    // Check if the current selection is bold
    bool isBold = _controller
        .getSelectionStyle()
        .attributes
        .containsKey(Attribute.bold.key);

    // Toggle the bold attribute
    if (isBold) {
      _controller.formatSelection(Attribute.clone(Attribute.bold, null));
    } else {
      _controller.formatSelection(Attribute.bold);
    }
  }
}
