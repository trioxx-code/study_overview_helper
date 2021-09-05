import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../util/Constants.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late File file;
  late TextEditingController _semesterController;
  late TextEditingController _noteController;
  late TextEditingController _fileController;
  late TextEditingController _hintController;
  late String _dozent;
  late String _class;

  @override
  void dispose() {
    _semesterController.dispose();
    _noteController.dispose();
    _fileController.dispose();
    _hintController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notizen"),
        actions: [
          TextButton(
            onPressed: () => readJson(),
            child: Text("Datei öffnen", style: TextStyle(fontSize: 24),),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }

  Future refresh() async {}

  /*Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _localFile async {
    final path = await _localPath;
    print(path);
    return File('$path/$fileName');
  }
  Future<int> readCounter() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      return int.parse(contents);
    } catch (e) {
      return 0;
    }
  }*/

  Future<void> readJson() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if(result != null) {
      final file = File(result.files.single.path);
      final String response = await file.readAsString();
      final data = await json.decode(response);
      print(data);
      setState(() {
        _semesterController = new TextEditingController(text:data[Constants.JSON_SEMESTER]);
        _class = data[Constants.JSON_CLASS];
        _fileController = new TextEditingController(text: data[Constants.JSON_FILES]);
        _dozent = data[Constants.JSON_DOZENT];
        _hintController = new TextEditingController(text: data[Constants.JSON_HINTS]);
        _noteController = new TextEditingController(text: data[Constants.JSON_NOTE]);
      });
    }
  }
}
