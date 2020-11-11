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

class ListRoomLoadSuccess extends ListRoomState {
  List<ChatRoomInfo> listRooms;

  ListRoomLoadSuccess({@required this.listRooms});

  @override
  List<Object> get props => [listRooms];
}

class ListRoomLoadError extends ListRoomState {
  String message;

  ListRoomLoadError({@required this.message});

  @override
  List<Object> get props => [];
}

class ChatRoomAdding extends ListRoomState {
  @override
  List<Object> get props => [];
}

class ChatRoomAddSucecss extends ListRoomState {
  @override
  List<Object> get props => [];
}