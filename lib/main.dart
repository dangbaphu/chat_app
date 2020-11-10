import 'package:chat_app/blocs/list_room/list_room_bloc.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screens/list_room/list_room_screen.dart';
import 'package:chat_app/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/blocs/auth_bloc/auth_bloc.dart';
//import 'package:chat_app/blocs/home_bloc/home_bloc.dart';

import 'blocs/simple_bloc_observer.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Open Chat',
      theme: ThemeData(
          primaryColor: Color(0xfffae7e9),
          accentColor: Color(0xfff2cbd0),
          appBarTheme: AppBarTheme(
            elevation: 0.0,
            color: Colors.transparent,
          )
      ),
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
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthFailure) {
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
        },
      ),
    );
  }
}
