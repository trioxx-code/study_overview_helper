import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as Q;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:study_overview_helper/Database/DatabaseHelper.dart';
import 'package:study_overview_helper/Database/models/StackModel.dart';
import 'package:study_overview_helper/util/Constants.dart';

class StackPage extends StatefulWidget {
  final String className;
  final int semester;
  final dynamic stackKey;

  const StackPage({required this.className, required this.semester, required this.stackKey});

  @override
  _StackPageState createState() => _StackPageState();
}

//@info: https://github.com/long1eu/rich_editor
//@info: --> https://github.com/memspace/zefyr
//TODO: https://pub.dev/packages/zefyr
//TODO: --> https://pub.dev/packages/flutter_quill
//@info: https://levelup.gitconnected.com/flutter-medium-like-text-editor-b41157f50f0e

class _StackPageState extends State<StackPage> {
  late Q.QuillController _controller;


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    openBox();
    final box = DatabaseHelper.getStacks();
    //print("KEY==" + widget.stackKey.toString()); //@debug
    if(widget.stackKey > box.length-1) {
      _controller = new Q.QuillController.basic();
    } else {
      //@debug
      /*box.keys.forEach((element) {
        print("Keys="+element.toString());
      });*/
      final StackModel v = box.getAt(widget.stackKey);
      //print(v.className); //@debug
      var json = jsonDecode(v.content[Constants.HIVE_STACK_CONTENT_KEY]);
      _controller = Q.QuillController(
          document: Q.Document.fromJson(json),
          selection: TextSelection.collapsed(offset: 0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.className),
        actions: [
          TextButton(
            onPressed: () {
              save();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey.shade400),
            ),
            child: Text(
              "Speichern",
              style: TextStyle(
                color: Colors.blue.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: buildQuill(),
    );
  }

  Future openBox() async {
    await Hive.openBox(Constants.HIVE_STACK);
  }

  Widget buildQuill() {
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(top: 8),
        child: Q.QuillToolbar.basic(controller: _controller),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            child:
                Q.QuillEditor.basic(controller: _controller, readOnly: false),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey, width: 5),
            ),
          ),
        ),
      ),
    ]);
  }

  Future save() async {
    final box = DatabaseHelper.getStacks();
    if(widget.stackKey > box.length-1){
      dynamic v = StackModel()
        ..className = widget.className
        ..content = {
          Constants.HIVE_STACK_CONTENT_KEY:
          jsonEncode(_controller.document.toDelta().toJson())
        };
      box.add(v);
      //print("A;Key=${widget.stackKey};className=${widget.className};");//@debug
    } else {
      dynamic v = box.getAt(widget.stackKey);
      v.className = widget.className;
      v.content = {
        Constants.HIVE_STACK_CONTENT_KEY:
        jsonEncode(_controller.document.toDelta().toJson())
      };
      v.save();
      //print("S;Key=${widget.stackKey};className=${widget.className};");//@debug
    }
  }

}
