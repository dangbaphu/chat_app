import 'package:flutter/material.dart';
import 'package:chat_app/screens/splash_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: SplashPage(),
      routes: {
      },
    );
  }
}
