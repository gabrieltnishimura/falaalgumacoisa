import 'package:falaalgumacoisa/pages/record_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(FalaAlgumaCoisaApp());
}

class FalaAlgumaCoisaApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: RecordPage(),
        navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)]);
  }
}
