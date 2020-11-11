part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EditNameChanged extends EditProfileEvent {
  final String name;

  EditNameChanged({this.name});

  @override
  List<Object> get props => [name];
}

class EditProfileSubmitted extends EditProfileEvent {
  final String name;
  File image;

  EditProfileSubmitted({this.name, this.image});

  @override
  List<Object> get props => [name, image];
}