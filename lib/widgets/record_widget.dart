import 'package:falaalgumacoisa/bloc/record_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordWidget extends StatefulWidget {
  @override
  _RecordWidget createState() => _RecordWidget();
}

class _RecordWidget extends State<RecordWidget> {
  RecordBloc _recordBloc;

  @override
  void initState() {
    _recordBloc = BlocProvider.of<RecordBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordBloc, RecordState>(builder: (context, state) {
      return Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              onPressed: () {
                _recordBloc.add(state.nextEvent);
              },
              icon: state.icon,
              color: Colors.grey,
              iconSize: 200,
            ),
          ],
        ),
      ]);
    });
  }

  @override
  void dispose() {
    _recordBloc.close();
    super.dispose();
  }
}
