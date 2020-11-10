import 'package:flutter/material.dart';
import 'package:chat_app/screens/splash_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/blocs/auth_bloc/auth_bloc.dart';
//import 'package:chat_app/blocs/home_bloc/home_bloc.dart';

import 'blocs/simple_bloc_observer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      // home: SplashPage(),
      // routes: {
      // },
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
