import 'package:flutter/material.dart';
import 'package:chat_app/screens/splash_page.dart';
import 'package:chat_app/screens/list_room/list_room_screen.dart';
import 'package:chat_app/locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: ListRoomScreen(),
      routes: {
      },
    );
  }
}
