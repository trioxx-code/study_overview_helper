import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:study_overview_helper/util/Constants.dart';

class StackPage extends StatefulWidget {
  final String className;
  final int semester;

  const StackPage({required this.className, required this.semester});

  @override
  _StackPageState createState() => _StackPageState();
}

//@info: https://github.com/long1eu/rich_editor
//@info: --> https://github.com/memspace/zefyr
//TODO: https://pub.dev/packages/zefyr
//TODO: --> https://pub.dev/packages/flutter_quill
//@info: https://levelup.gitconnected.com/flutter-medium-like-text-editor-b41157f50f0e

class _StackPageState extends State<StackPage> {

  TextEditingController _contentController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    openBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.className),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  maxLines: 30,
                  controller: _contentController,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: Constants.JSON_NOTE,
                    labelStyle: TextStyle(
                      fontSize: 48,
                      color: Colors.lightBlue.shade400,
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.blueGrey, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.lightBlue.shade400, width: 2.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future openBox() async {
    await Hive.openBox(Constants.HIVE_STACK);
  }

}
