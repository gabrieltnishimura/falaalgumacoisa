import 'package:falaalgumacoisa/bloc/record_bloc.dart';
import 'package:falaalgumacoisa/services/audio_player_service.dart';
import 'package:falaalgumacoisa/services/local_file_system_service.dart';
import 'package:falaalgumacoisa/services/record_service.dart';
import 'package:falaalgumacoisa/widgets/record_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'service_locator_mock.dart';

void main() {
  setUp(() {
    setupMockLocators();
  });

  testWidgets('Initial loading of RecordWidget shows mic icon',
      (WidgetTester tester) async {
    final RecordService recordService = locator<RecordService>();
    final AudioPlayerService audioPlayerService = locator<AudioPlayerService>();
    final LocalFileSystemService localFileSystemService =
        locator<LocalFileSystemService>();

    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: BlocProvider(
                create: (context) => RecordBloc(
                    recordService: recordService,
                    audioPlayerService: audioPlayerService,
                    localFileSystemService: localFileSystemService),
                child: RecordWidget()))));

    expect(find.byIcon(Icons.mic), findsOneWidget);
  });
}
