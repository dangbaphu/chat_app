import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/blocs/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:chat_app/models/user.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileForm extends StatefulWidget {
  final User user;
  const EditProfileForm({Key key, this.user}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<EditProfileForm> {
  File _image;
  final TextEditingController _nameController = TextEditingController();

  bool get isPopulated =>
      _nameController.text.isNotEmpty;

  bool isButtonEnabled(EditProfileState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  EditProfileBloc editProfileBloc;

  @override
  void initState() {
    super.initState();
    editProfileBloc = BlocProvider.of<EditProfileBloc>(context);
    _nameController.text = widget.user.name;
    _nameController.addListener(_onEmailChange);
  }

  @override
  Widget build(BuildContext context) {
//    _nameController.text = widget.user.name;

    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Register Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Color(0xffffae88),
              ),
            );
        }

        if (state.isSubmitting) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Chỉnh sửa...'),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  ],
                ),
                backgroundColor: Color(0xffffae88),
              ),
            );
        }

        if (state.isSuccess) {
          BlocProvider.of<AuthBloc>(context).add(
            AuthLoggedIn(),
          );
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
          print(state.isNameValid);
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  Container(
                    child: _image == null
                        ? CircleAvatar(backgroundImage: new NetworkImage(widget.user.imgUrl), radius: 70.0)
                        : CircleAvatar(backgroundImage: new FileImage(_image), radius: 70.0)
                  ),
                  RaisedButton(
                      onPressed: () {
                        getImage();
                      },
                      child: Text('Tải Ảnh')),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                    ),
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isNameValid ? 'Name không đúng định dạng' : null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FlatButton(
                    height: 45,
                    color: Colors.green,
                    onPressed: () {
                      if (isButtonEnabled(state)) {
                        _onFormSubmitted();
                      }
                    },
                    child: Text(
                      'Cập nhật',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onEmailChange() {
    print('vao');
    editProfileBloc.add(EditNameChanged(name: _nameController.text));
  }


  void _onFormSubmitted() {
    editProfileBloc.add(EditProfileSubmitted(
        name: _nameController.text, image: _image));
  }

  Future getImage() async {
    final picker = ImagePicker();
    await picker.getImage(source: ImageSource.gallery).then((value) =>
    {
      setState(() {
        _image = File(value.path);
      })
    });
  }
}
