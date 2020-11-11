import 'package:bloc/bloc.dart';
import 'package:chat_app/blocs/list_room/list_room_event.dart';
import 'package:chat_app/blocs/list_room/list_room_state.dart';
import 'package:chat_app/services/list_rooms_service.dart';
import 'package:meta/meta.dart';
import 'package:chat_app/models/chat_room_info.dart';
import 'dart:async';

class ListRoomBloc extends Bloc<ListRoomEvent, ListRoomState> {

  ListRoomBloc() : super(ListRoomInitial());

  StreamSubscription listRooms;

  @override
  Stream<ListRoomState> mapEventToState(ListRoomEvent event) async* {
    if (event is ListRoomStart) {
      yield ListRoomLoading();
      listRooms?.cancel();
      listRooms = listRoomsService.getChatRooms().listen((rooms) {
          add(ListRoomLoad(listRooms: rooms));
      });
    } else if (event is ListRoomLoad) {
      yield* _mapListRoomToState(event.listRooms);
    } else if (event is AddChatRoom) {
      yield* _mapChatListAddToState(event.title);

    }
  }

  Stream<ListRoomState> _mapListRoomToState(List<ChatRoomInfo> rooms) async* {
    yield ListRoomLoaded(listRooms: rooms);
  }
  Stream<ListRoomState> _mapChatListAddToState(String title) async* {
    await listRoomsService.addChatList(title);
    yield ChatRoomAddSucecss();
  }
}
