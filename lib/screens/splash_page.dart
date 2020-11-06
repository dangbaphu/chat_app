import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _redirectPageByAuthenticate();
  }

  _redirectPageByAuthenticate() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString('token');
    //
    // if (token != null) {
    //   await Navigator.of(context).pushNamed('/users');
    // }
    await Navigator.of(context).pushNamedAndRemoveUntil('/register', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
              child: Container(
                  child: Text('splash page',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 50.0))),
            )));
  }
}
