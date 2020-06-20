import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inbreif/Screens/Loading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Brief_Loading()
    );
  }
}

