import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/blocs/home_bloc/home_bloc.dart';
import 'package:chat_app/locator.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/screens/login/login_screen.dart';

import 'blocs/simple_bloc_observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  setupLocator();
  runApp(
    BlocProvider(
      create: (context) => AuthBloc()..add(AuthStarted()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat app',
      theme: ThemeData(
          primaryColor: Color(0xff9ccc65),
          accentColor: Color(0xff689f38),
          appBarTheme: AppBarTheme(
            elevation: 0.0,
            color: Colors.transparent,
          )
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthFailure
            || state is AuthInitial) {
            return LoginScreen();
          }

          if (state is AuthSuccess) {
            return BlocProvider(
              create: (context) => HomeBloc(),
              child: HomeScreen(
                user: state.user,
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(),
            body: Container(
              child: Center(
                child: Text('Loading'),
              ),
            ),
          );
        },
      ),
    );
  }
}

