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

class ListRoomAdd extends ListRoomEvent {
  final String title;

  ListRoomAdd({this.title});

  @override
  List<Object> get props => [title];
}