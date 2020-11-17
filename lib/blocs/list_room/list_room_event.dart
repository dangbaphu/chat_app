import 'package:equatable/equatable.dart';
import 'package:chat_app/models/chat_room_info.dart';

abstract class ListRoomEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ListRoomStart extends ListRoomEvent {}

class ListRoomLoad extends ListRoomEvent {
  final List<ChatRoomInfo> listRooms;

  ListRoomLoad({this.listRooms});

  @override
  List<Object> get props => [listRooms];
}

class AddChatRoom extends ListRoomEvent {
  final String userCreate;
  final String title;
  final String password;

  AddChatRoom({this.userCreate, this.title, this.password});

  @override
  List<Object> get props => [userCreate, title, password];
}