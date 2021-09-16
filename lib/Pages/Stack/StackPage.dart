import 'package:flutter/material.dart';

class StackPage extends StatefulWidget {
  final String className;
  final int semester;

  const StackPage({required this.className, required this.semester});

  @override
  _StackPageState createState() => _StackPageState();
}

class _StackPageState extends State<StackPage> {
  //TODO: Model für Stack fertig machen

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.className),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
