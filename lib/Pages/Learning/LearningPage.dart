import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:study_overview_helper/Database/DatabaseHelper.dart';
import 'package:study_overview_helper/Database/models/StudyClassModel.dart';
import 'package:study_overview_helper/Pages/Learning/AddEditLearningStack.dart';
import 'package:study_overview_helper/Pages/Stack/StackPage.dart';
import 'package:study_overview_helper/util/Constants.dart';

class LearningPage extends StatefulWidget {
  @override
  _LearningPageState createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  @override
  void initState() {
    super.initState();
    openBox();
  }

  @override
  void dispose() {
    //Hive.close();
    super.dispose();
  }

//@info: https://www.youtube.com/watch?v=w8cZKm9s228
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddEditLearningStack(),
          ));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Lern-System"),
      ),
      body: ValueListenableBuilder<Box>(
        valueListenable: DatabaseHelper.getClasses().listenable(),
        builder: (context, value, child) {
          final val = value.values.toList().cast<StudyClassModel>();
          return buildContent(val);
        },
      ),
    );
  }

  Widget buildContent(List<StudyClassModel> values) {
    return ListView.separated(
      padding: EdgeInsets.all(30),
      itemBuilder: (context, index) => Container(
        child: ListTile(
          tileColor: Colors.blueGrey.shade800,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => StackPage(
                className: values[index].className,
                semester: values[index].semester,
                stackKey: values[index].key,
              ),
            ));
          },
          title: Text(
            values[index].className,
            style: TextStyle(
              fontSize: 24,
              color: Colors.yellow.shade400,
            ),
          ),
          subtitle: Text(
            values[index].semester.toString(),
            style: TextStyle(fontSize: 18, color: Colors.lime),
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              values[index].delete();
            },
          ),
          leading: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddEditLearningStack(scm: values[index]),
              ));
            },
          ),
        ),
      ),
      separatorBuilder: (context, index) => SizedBox(
        height: 10,
      ),
      itemCount: values.length,
    );
  }

  Future openBox() async {
    await Hive.openBox(Constants.HIVE_STUDY_CLASS);
  }
}
