import 'package:falaalgumacoisa/widgets/record_widget.dart';
import 'package:falaalgumacoisa/widgets/upload_widget.dart';
import 'package:falaalgumacoisa/widgets/word_suggestion_widget.dart';
import 'package:flutter/material.dart';

class RecordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          WordSuggestionWidget(),
          RecordWidget(),
          UploadWidget(),
        ],
      ),
    );
  }
}
