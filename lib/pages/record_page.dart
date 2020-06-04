import 'package:falaalgumacoisa/bloc/record_bloc.dart';
import 'package:falaalgumacoisa/pages/success_page.dart';
import 'package:falaalgumacoisa/service_locator.dart';
import 'package:falaalgumacoisa/services/audio_player_service.dart';
import 'package:falaalgumacoisa/services/local_file_system_service.dart';
import 'package:falaalgumacoisa/services/record_service.dart';
import 'package:falaalgumacoisa/widgets/record_widget.dart';
import 'package:falaalgumacoisa/widgets/word_suggestion_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordPage extends StatelessWidget {
  final RecordService recordService = locator<RecordService>();
  final AudioPlayerService audioPlayerService = locator<AudioPlayerService>();
  final LocalFileSystemService localFileSystemService =
      locator<LocalFileSystemService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Record Page'),
        ),
        body: BlocProvider(
            create: (context) => RecordBloc(
                recordService: recordService,
                audioPlayerService: audioPlayerService,
                localFileSystemService: localFileSystemService),
            child: Center(
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
            )));
  }
}
