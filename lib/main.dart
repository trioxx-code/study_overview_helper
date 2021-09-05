import 'package:flutter/material.dart';
import 'package:study_overview_helper/Pages/AddEditNotePage.dart';
import 'package:study_overview_helper/Pages/NotesPage.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey,
        ),
        brightness: Brightness.dark
      ),
      home: homeBuilder(context),
    );
  }

  Widget homeBuilder(BuildContext context) {
    return new Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              OptionButton(() {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddEditNotePage(fileName: null,)));
              }, "Neue Notiz"),
              SizedBox(height: 10),
              OptionButton(() {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => NotesPage()));
              }, "Notizen ansehen"),
            ],
          ),
        ),
      );
    });
  }

  Widget OptionButton(dynamic onPressed, String text) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
        foregroundColor: MaterialStateProperty.all(Colors.yellow),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 48,
        ),
      ),
    );
  }
}
