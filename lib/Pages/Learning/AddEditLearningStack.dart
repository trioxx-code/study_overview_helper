import 'package:flutter/material.dart';
import 'package:study_overview_helper/Database/DatabaseHelper.dart';
import 'package:study_overview_helper/Database/models/StudyClassModel.dart';
import 'package:study_overview_helper/util/Constants.dart';

class AddEditLearningStack extends StatefulWidget {
  StudyClassModel? scm;

  AddEditLearningStack({scm});

  @override
  _AddEditLearningStackState createState() => _AddEditLearningStackState();
}

class _AddEditLearningStackState extends State<AddEditLearningStack> {
  late TextEditingController _nameController;
  late TextEditingController _semesterController;
  late StudyClassModel scm;

  @override
  void initState() {
    super.initState();
    if (widget.scm != null) {
      _nameController = new TextEditingController(text: widget.scm!.className);
      _semesterController =
          new TextEditingController(text: widget.scm!.semester.toString());
    } else {
      _nameController = new TextEditingController();
      _semesterController = new TextEditingController();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _semesterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stack"),
        actions: [
          TextButton(
            onPressed: () {
              saveAndLeave();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: _nameController,
              style: TextStyle(
                fontSize: 28,
              ),
              decoration: InputDecoration(
                labelText: "Stack Name",
                labelStyle:
                    TextStyle(color: Colors.indigo.shade200, fontSize: 28),
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.indigo.shade200, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.indigo.shade200, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: 300,
              child: TextField(
                controller: _semesterController,
                style: TextStyle(color: Colors.cyan.shade300, fontSize: 28),
                maxLength: 1,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: Constants.JSON_SEMESTER,
                  labelStyle:
                      TextStyle(color: Colors.indigo.shade200, fontSize: 28),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.indigo.shade200, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.indigo.shade200, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  void saveAndLeave() async {
    if (_nameController.text.isNotEmpty &&
        _semesterController.text.isNotEmpty) {
      final stack = StudyClassModel()
        ..className = _nameController.text
        ..semester = int.parse(_semesterController.text);
      final box = DatabaseHelper.getClasses();
      box.add(stack);
      Navigator.of(context).pop();
    }
  }
}
