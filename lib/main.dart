import 'package:chat_app/screens/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screens/splash_page.dart';
import 'package:chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/blocs/auth_bloc/auth_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/locator.dart';

void main() {
  setupLocator();
  runApp(
    BlocProvider(
      create: (context) => AuthBloc()..add(AuthStarted()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: SplashPage(),
      routes: {
        '/register': (context) => RegisterPage(),
      },
    );
  }
}
