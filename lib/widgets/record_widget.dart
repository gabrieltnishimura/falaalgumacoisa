import 'package:falaalgumacoisa/services/record_service.dart';
import 'package:flutter/material.dart';

import '../service_locator.dart';

class RecordWidget extends StatefulWidget {
  @override
  _RecordWidget createState() => _RecordWidget();
}

class _RecordWidget extends State<RecordWidget> {
  final RecordService _recordService = locator<RecordService>();
  bool recording = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            onPressed: recording ? _stopRecording : _startRecording,
            icon: recording ? Icon(Icons.pause) : Icon(Icons.mic),
            color: Colors.grey,
            iconSize: 200,
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            onPressed: _playRecording,
            icon: Icon(Icons.play_arrow),
            color: Colors.green,
            iconSize: 40,
          ),
        ],
      )
    ]);
  }

  void _startRecording() async {
    await _recordService.record();
    setState(() {
      recording = true;
    });
  }

  void _playRecording() async {
    return _recordService.play();
  }

  void _stopRecording() async {
    await _recordService.stop();
    setState(() {
      recording = false;
    });
  }
}
