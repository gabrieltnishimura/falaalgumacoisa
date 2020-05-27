import 'package:falaalgumacoisa/services/word_suggestion_service.dart';
import 'package:flutter/material.dart';

import '../service_locator.dart';

class WordSuggestionWidget extends StatefulWidget {
  @override
  _WordSuggestionWidget createState() => _WordSuggestionWidget();
}

class _WordSuggestionWidget extends State<WordSuggestionWidget> {
  final WordSuggestionService _wordSuggestionService =
      locator<WordSuggestionService>();

  String word;

  _WordSuggestionWidget() {
    _wordSuggestionService.getWordSuggestion().then((value) {
      setState(() {
        word = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'A próxima palavra é:',
          style: TextStyle(
            fontWeight: FontWeight.w200,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        word != null
            ? Text(
                word,
                style: TextStyle(fontSize: 40),
                textAlign: TextAlign.center,
              )
            : Container(),
        SizedBox(height: 10),
        Center(
            child: Text(
          ' Clique para gravar, leia a palavra em voz alta e clique novamente para parar ',
          style: TextStyle(fontWeight: FontWeight.w200),
          textAlign: TextAlign.center,
        )),
      ],
    );
  }
}
