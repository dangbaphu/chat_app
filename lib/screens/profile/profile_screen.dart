import 'package:chat_app/screens/edit_profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/models/user.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new IconButton(icon: new Icon(Icons.edit_sharp),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return EditProfileScreen(user: user);
                }));
              },
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 100),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(60),
            )),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(user.imgUrl),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              user.name,
              style: TextStyle(
                fontSize: 25,
                color: Color(0xff6a515e),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              user.id,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xffc7abba),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              user.email,
              style: TextStyle(
                fontSize: 25,
                color: Color(0xff6a515e),
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
    );
  }
}
