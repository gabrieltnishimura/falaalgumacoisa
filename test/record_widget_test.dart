import 'package:falaalgumacoisa/widgets/record_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'service_locator_mock.dart';

void main() {
  setUp(() {
    setupMockLocators();
  });

  testWidgets('Follow recording flow (record, stop, play, pause)',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: RecordWidget())));
    expect(find.byIcon(Icons.mic), findsOneWidget);

    await tester.tap(find.byIcon(Icons.mic));
    await tester.pump();

    expect(find.byIcon(Icons.pause), findsOneWidget);

    await tester.tap(find.byIcon(Icons.pause));
    await tester.pump();

    expect(find.byIcon(Icons.play_arrow), findsOneWidget);

    await tester.tap(find.byIcon(Icons.play_arrow));
    await tester.pump();

    expect(find.byIcon(Icons.pause), findsOneWidget);
  });
}
