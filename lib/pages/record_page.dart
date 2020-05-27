import 'package:falaalgumacoisa/pages/success_page.dart';
import 'package:falaalgumacoisa/widgets/record_widget.dart';
import 'package:falaalgumacoisa/widgets/word_suggestion_widget.dart';
import 'package:flutter/material.dart';

class RecordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Record Page'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              WordSuggestionWidget(),
              RecordWidget(),
              RaisedButton(
                child: Text(
                  'Enviar',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SuccessPage()),
                  );
                },
              )
            ],
          ),
        ));
  }
}
