import 'package:chat_app/screens/register/register_form.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/blocs/register_bloc/register_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.red,
              width: double.infinity,
              height: 200,
              child: Text('ĐĂNG KÝ', style: TextStyle(fontSize: 40, color: Colors.amber)),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: RegisterForm(),
            )
          ],
        ),
      ),
    );
  }
}
