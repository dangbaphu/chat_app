import 'package:chat_app/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {

}

class AuthSuccess extends AuthState {
  final User user;

  AuthSuccess({this.user});

  @override
  List<Object> get props => [user];
}

class AuthFailure extends AuthState {}
