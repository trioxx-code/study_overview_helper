import 'dart:convert';
import 'dart:io';

import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:study_overview_helper/Constants.dart';

class AddEditNotePage extends StatefulWidget {
  final String? fileName;

  AddEditNotePage({required this.fileName});

  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  TextEditingController _semesterController = new TextEditingController();
  TextEditingController _noteController = new TextEditingController();
  TextEditingController _fileController = new TextEditingController();
  TextEditingController _hintController = new TextEditingController();
  TextEditingController _fileNameController = new TextEditingController();

  dynamic _dozent;
  dynamic _class;

  late File file;
  late bool fileExists = false;
  late Directory dir;
  late String fileName = "";
  late Map fileContent;
  late String path = "";

  @override
  void dispose() {
    _semesterController.dispose();
    _noteController.dispose();
    _fileController.dispose();
    _hintController.dispose();
    _fileNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.fileName == null) {
      fileName = Constants.DEFAULT_FILE_NAME;
      fileExists = false;
    } else {
      fileName = widget.fileName!;
      fileExists = true;
    }
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      file = new File(path + "/" + fileName);
      fileExists = file.existsSync();
      if (fileExists)
        this.setState(() => fileContent = json.decode(file.readAsStringSync()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Neue Notiz"),
        actions: [
          TextButton(
            onPressed: () async {
              await save();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey.shade400),
            ),
            child: Text(
              "Speichern",
              style: TextStyle(
                color: Colors.green.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Row(
            children: [
              Container(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: _semesterController,
                    style: TextStyle(color: Colors.cyan.shade300),
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: Constants.JSON_SEMESTER,
                      labelStyle: TextStyle(color: Colors.indigo.shade200),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.indigo.shade200, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.indigo.shade200, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                child: DropdownButton<String>(
                  focusColor: Colors.tealAccent,
                  value: _dozent,
                  //elevation: 5,
                  style: TextStyle(color: Colors.indigo.shade200),
                  iconEnabledColor: Colors.indigo.shade200,
                  items: <String>[
                    'Android',
                    'IOS',
                    'Flutter',
                    'Node',
                    'Java',
                    'Python',
                    'PHP',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.indigo.shade200),
                      ),
                    );
                  }).toList(),
                  hint: Text(
                    Constants.JSON_DOZENT,
                    style: TextStyle(
                        color: Colors.indigo.shade200,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _dozent = value;
                    });
                  },
                ),
              ),
              SizedBox(width: 10),
              Container(
                child: DropdownButton<String>(
                  focusColor: Colors.tealAccent,
                  value: _class,
                  //elevation: 5,
                  style: TextStyle(color: Colors.indigo.shade200),
                  iconEnabledColor: Colors.indigo.shade200,
                  items: <String>[
                    'Android',
                    'IOS',
                    'Flutter',
                    'Node',
                    'Java',
                    'Python',
                    'PHP',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.indigo.shade200),
                      ),
                    );
                  }).toList(),
                  hint: Text(
                    Constants.JSON_CLASS,
                    style: TextStyle(
                        color: Colors.indigo.shade200,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _class = value;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: _fileNameController,
                    style: TextStyle(color: Colors.cyan.shade300),
                    decoration: InputDecoration(
                      labelText: Constants.FILE_NAME,
                      labelStyle: TextStyle(color: Colors.indigo.shade200),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.indigo.shade200, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.indigo.shade200, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.blueGrey,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 5,
                controller: _fileController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: Constants.JSON_FILES,
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 48),
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blueGrey, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.indigo, width: 2.0),
                  ),
                ),
              ),
            ),
          ),
          Divider(),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 5,
                controller: _hintController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: Constants.JSON_HINTS,
                  labelStyle: TextStyle(color: Colors.deepOrange, fontSize: 48),
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blueGrey, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.indigo, width: 2.0),
                  ),
                ),
              ),
            ),
          ),
          Divider(),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 30,
                controller: _noteController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: Constants.JSON_NOTE,
                  labelStyle: TextStyle(
                    fontSize: 48,
                    color: Colors.indigo,
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blueGrey, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.indigo, width: 2.0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ]),
      ),
    );
  }

  Future refresh() async {
    setState(() {});
    //TODO
    setState(() {});
  }

  Future save() async {
    Directory rootPath = dir;
    path = (await FilesystemPicker.open(
      title: 'Speichern',
      context: context,
      rootDirectory: rootPath,
      fsType: FilesystemType.folder,
      pickText: 'Hier Speichern',
      folderIconColor: Colors.teal,
    ))!;
    print(path);
    writeToFile({
      Constants.JSON_SEMESTER: "${_semesterController.text}",
      Constants.JSON_CLASS: _class,
      Constants.JSON_FILES: _fileController.text,
      Constants.JSON_DOZENT: _dozent,
      Constants.JSON_HINTS: _hintController.text,
      Constants.JSON_NOTE: _noteController.text,
    });
  }

  void createFile(
      Map<String, dynamic> content, Directory dir, String fileName) {
    print("Creating file!");
    if (_fileNameController.text.isNotEmpty)
      fileName = _fileNameController.text;
    File file = new File(path + "/" + fileName + Constants.DEFAULT_FILE_SUFFIX);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(content));
  }

  void writeToFile(Map<String, dynamic> content) {
    print("Writing to file!");
    if (fileExists &&
        file.absolute ==
            path + "/" + fileName + Constants.DEFAULT_FILE_SUFFIX) {
      print("File exists");
      Map<String, dynamic> jsonFileContent =
          json.decode(file.readAsStringSync());
      jsonFileContent.addAll(content);
      file.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      print("File does not exist!");
      createFile(content, dir, fileName);
    }
  }
}
