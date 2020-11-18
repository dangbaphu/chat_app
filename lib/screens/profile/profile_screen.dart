import 'package:chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/screens/edit_profile/edit_profile_screen.dart';
// import 'package:chat_app/screens/edit_profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
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
          ),
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(user.imgUrl),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        user.name,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff6a515e),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ),
                ListTile(
                  title: Text('Edit Profile'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return EditProfileScreen(user: user);
                    }));
                  },
                ),
                // ListTile(
                //   title: Text('Change Password'),
                //   onTap: () {
                //     Navigator.push(context, MaterialPageRoute(builder: (_) {
                //       return EditProfileScreen(user: user);
                //     }));
                //   },
                // ),
                ListTile(
                  title: Text('Logout'),
                  onTap: () {
                    context.bloc<AuthBloc>().add(AuthLoggedOut());
                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),
              ],
            ),
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
    );
  }
}
