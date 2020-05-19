import 'package:falaalgumacoisa/widgets/record-widget.dart';
import 'package:falaalgumacoisa/widgets/upload-widget.dart';
import 'package:flutter/material.dart';

class RecordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Press play to record and stop to stop recording',
          ),
          RecordWidget(),
          UploadWidget(),
        ],
      ),
    );
  }
}
