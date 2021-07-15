import 'package:firebase_rick_and_morty/view/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'services/analytics_firebase_service.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.black,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      navigatorObservers: [AnalyticsService.instance.getAnalyticsObserver()],
      initialRoute: 'SplashView',
      routes: {
        'SplashView': (context) => SplashView(),
      },
    );
  }
}
