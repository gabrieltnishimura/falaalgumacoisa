import 'package:falaalgumacoisa/pages/record-page.dart';
import 'package:flutter/material.dart';

class AppWrapper extends StatefulWidget {
  AppWrapper({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AppWrapperState createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: RecordPage());
  }
}
