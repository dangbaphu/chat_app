import 'package:chat_app/blocs/list_room/list_room_bloc.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screens/splash_page.dart';
import 'package:chat_app/screens/list_room/list_room_screen.dart';
import 'package:chat_app/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
                builder: (context) => BlocProvider<ListRoomBloc>(
                      create: (context) => ListRoomBloc(),
                      child: ListRoomScreen(),
                    ));
          default:
            return MaterialPageRoute(builder: (context) {
              return Scaffold(
                body: Center(
                  child: Text('deo thay route okiee!!'),
                ),
              );
            });
        }
      },
      initialRoute: '/',
    );
  }
}
