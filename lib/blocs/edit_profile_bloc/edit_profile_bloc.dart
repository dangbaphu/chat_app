import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:chat_app/locator.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/utils/validators.dart';

part 'edit_profile_event.dart';

part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final AuthService _authService = locator<AuthService>();

  EditProfileBloc() : super(EditProfileState.initial());

  @override
  Stream<EditProfileState> mapEventToState(EditProfileEvent event) async* {
    if (event is EditNameChanged) {
      yield* _mapEditNameChangeToState(event.name);
    } else if (event is EditProfileSubmitted) {
      yield* _mapEditProfileSubmittedToState(
          name: event.name, image: event.image);
    }
  }

  Stream<EditProfileState> _mapEditNameChangeToState(String name) async* {
    yield state.update(isNameValid: Validators.isValidName(name));
  }

  Stream<EditProfileState> _mapEditProfileSubmittedToState(
      {String name, File image}) async* {
    yield EditProfileState.loading();
    try {
      String imgUrl;
      if(image != null){
        imgUrl = await _authService.uploadFile(image);
      }
      await _authService.updateProfileUser(name, imgUrl);
      yield EditProfileState.success();
    } catch (error) {
      print(error);
      yield EditProfileState.failure();
    }
  }
}
