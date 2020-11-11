import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/blocs/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/screens/edit_profile/edit_profile_form.dart';
import 'package:chat_app/widgets/curved_widget.dart';

class EditProfileScreen extends StatelessWidget {
  final User user;

  const EditProfileScreen({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Chỉnh sửa thông tin', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: BlocProvider<EditProfileBloc>(
        create: (context) => EditProfileBloc(),
        child: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 150),
                  child: EditProfileForm(user: user),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
