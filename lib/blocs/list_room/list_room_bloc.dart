import 'package:bloc/bloc.dart';
import 'package:chat_app/blocs/list_room/list_room_event.dart';
import 'package:chat_app/blocs/list_room/list_room_state.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/models/chat_room_info.dart';
import 'dart:async';

class ListRoomBloc extends Bloc<ListRoomEvent, ListRoomState> {

  ListRoomBloc() : super(ListRoomInitial());


  @override
  Stream<ListRoomState> mapEventToState(ListRoomEvent event) async* {
    if (event is ListRoomStart) {
      yield ListRoomLoading();
      chatService.getChatRooms().listen((rooms) {
          add(ListRoomLoad(listRooms: rooms));
      });
    } else if (event is ListRoomLoad) {
      yield* _mapListRoomToState(event.listRooms);
    } else if (event is AddChatRoom) {
      yield* _mapChatListAddToState(event.userCreate, event.title, event.password);

    }
  }

  Stream<ListRoomState> _mapListRoomToState(List<ChatRoomInfo> rooms) async* {
    rooms.sort((a, b) {
      return b.lastModified.compareTo(a.lastModified);
    });
    yield ListRoomLoadSuccess(listRooms: rooms);
  }
  Stream<ListRoomState> _mapChatListAddToState(String userCreate, String title, String password) async* {
    await chatService.addChatList(userCreate, title, password);
    yield ChatRoomAddSucecss();
  }
}
