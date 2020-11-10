
import 'package:chat_app/models/chat_room_info.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ListRoomState extends Equatable {
  const ListRoomState();
}

class ListRoomInitial extends ListRoomState {
  @override
  List<Object> get props => [];
}

class ListRoomLoading extends ListRoomState {
  @override
  List<Object> get props => [];
}

class ListRoomLoaded extends ListRoomState {
  List<ChatRoomInfo> listRooms;

  ListRoomLoaded({@required this.listRooms});

  @override
  List<Object> get props => [listRooms];
}

class ListRoomError extends ListRoomState {
  String message;

  ListRoomError({@required this.message});

  @override
  List<Object> get props => [];
}