import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'service_locator.dart';

import 'wrapper/app_wrapper.dart';

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
        home: Scaffold(body: AppWrapper(title: 'Fala Alguma Coisa')),
        navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)]);
  }
}
