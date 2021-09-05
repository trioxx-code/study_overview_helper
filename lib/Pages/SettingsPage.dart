import 'package:flutter/material.dart';
import 'package:study_overview_helper/util/Storage.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController _controller = new TextEditingController();
  bool isNullClasses = true;
  bool isNullDozents = true;
  List<String>? classes = [];
  List<String>? dozents = [];

  @override
  void dispose() {
    _controller.dispose();
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
        title: Text("Einstellungen"),
        actions: [
          Container(
            width: 300,
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Eingabe",
                labelStyle: TextStyle(color: Colors.indigo.shade200,fontSize: 18),
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
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Eingabe",
                labelStyle: TextStyle(color: Colors.indigo.shade200,fontSize: 28),
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
            Divider(
              color: Colors.deepPurple,
              thickness: 3,
            ),
            SizedBox(height: 20,),
            SettingsPageText("Fächer"),
            SizedBox(height: 10,),
            SettingsPageTextButton((){
                  if(_controller.text.isNotEmpty) {
                    setState(() {
                      classes!.add(_controller.text);
                      _controller.clear();
                    });
                    save(Storage.SP_CLASSES, classes!);
                  }
                }, "Fach"),
            SizedBox(height: 10,),
            ListView.separated(
              padding: EdgeInsets.all(15),
              separatorBuilder: (context, index) => SizedBox(height: 10,),
              shrinkWrap: true,
              itemCount: isNullClasses
                  ? 1
                  : classes!.isEmpty
                      ? 1
                      : show(isNullClasses | (classes!.length == 0))? 1 : classes!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  tileColor: Colors.grey.shade600,
                  title: Text(
                      (show(isNullClasses | (classes!.length == 0)) ? "Keine Eingetragen" : classes![index])),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      if(!isNullClasses)
                        setState((){
                          classes!.removeAt(index);
                        });
                      save(Storage.SP_CLASSES,classes!);
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.deepPurple,
              thickness: 3,
            ),
            SettingsPageText("Dozenten"),
            SizedBox(height: 10,),
            SettingsPageTextButton((){
                  print(_controller.text);
                  print(_controller.text.isNotEmpty);
                  if(_controller.text.isNotEmpty) {
                    setState(() {
                      dozents!.add(_controller.text);
                      _controller.clear();
                    });
                    save(Storage.SP_DOZENTS, dozents!);
                  }
                }, "Dozent",),
            SizedBox(height: 10,),
            ListView.separated(
              padding: EdgeInsets.all(15),
              separatorBuilder: (context, index) => SizedBox(height: 10,),
              shrinkWrap: true,
              itemCount: isNullDozents
                  ? 1
                  : dozents!.isEmpty
                      ? 1
                      : show(isNullDozents | (dozents!.length == 0))? 1 : dozents!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  tileColor: Colors.grey.shade600,
                  title: Text(
                      (show(isNullDozents | (dozents!.length == 0)) ? "Keine Eingetragen" : dozents![index])),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      if(!show(isNullDozents | (dozents!.length == 0)))
                        setState((){
                          dozents!.removeAt(index);
                        });
                      save(Storage.SP_DOZENTS, dozents!);
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  bool show(bool s) => s;

  Future refresh() async {
    setState(() {});
    classes = await Storage.readDataStringList(Storage.SP_CLASSES);
    if (classes != null) isNullClasses = false;
    else classes = [];
    dozents = await Storage.readDataStringList(Storage.SP_DOZENTS);
    if (dozents != null) isNullDozents = false;
    else dozents = [];
    setState(() {});
  }

  void save(String key, List<String> value) {
    Storage.saveDataStringList(key, value);
  }

  Widget SettingsPageText(String text) {
    return Text(text,
      style: TextStyle(
        color: Colors.deepPurple.shade300,
        fontSize: 48,
        decoration: TextDecoration.underline,
      ),);
  }

  Widget SettingsPageTextButton(dynamic onPressed, String text) {
    return TextButton(
      onPressed: onPressed,
      child: Text("$text Hinzufügen",
        style: TextStyle(
          color: Colors.purpleAccent,
        ),
      ),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(1),
        backgroundColor: MaterialStateProperty.all(Colors.deepPurple.shade900),
      ),
    );
  }

}
