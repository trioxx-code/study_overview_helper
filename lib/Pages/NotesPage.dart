import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:study_overview_helper/Constants.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late String semester = "";
  late String sClass = "";
  late String dozent = "";
  late String files = "";
  late String hints = "";
  late String notes = "";

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notizen"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(semester),
            Text(sClass),
            Text(dozent),
            Text(files),
            Text(hints),
            Text(notes),
            TextButton(
              onPressed: () => readJson(),
              child: Text("dnoawndoiawdiwnai"),
            ),
          ],
        ),
      ),
    );
  }

  Future refresh() async {}

  void readContent() {
    
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print(path);
    return File('$path/test.json');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<void> readJson() async {
    final file = await _localFile;
    final String response = await file.readAsString();
    final data = await json.decode(response);
    print(data);
    setState(() {
      semester = data[Constants.JSON_SEMESTER];
      sClass = data[Constants.JSON_CLASS];
      files = data[Constants.JSON_FILES];
      dozent = data[Constants.JSON_DOZENT];
      hints = data[Constants.JSON_HINTS];
      notes = data[Constants.JSON_NOTE];
    });
  }
}
