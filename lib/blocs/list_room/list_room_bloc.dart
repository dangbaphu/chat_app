import 'package:bloc/bloc.dart';
import 'package:chat_app/blocs/list_room/list_room_event.dart';
import 'package:chat_app/blocs/list_room/list_room_state.dart';
import 'package:chat_app/services/list_rooms_service.dart';
import 'package:meta/meta.dart';
import 'package:chat_app/models/chat_room_info.dart';
import 'dart:async';

class ListRoomBloc extends Bloc<ListRoomEvent, ListRoomState> {

  ListRoomsService repository;

  ListRoomBloc({@required this.repository});
  StreamSubscription listRooms;


  @override
  // TODO: implement initialState
  ListRoomState get initialState => ListRoomInitial();

  @override
  Stream<ListRoomState> mapEventToState(ListRoomEvent event) async* {
    if (event is ListRoomStart) {
      yield ListRoomLoading();
      listRooms?.cancel();
      listRooms = repository.getChatRooms().listen((rooms) {
        print(rooms);

        if (rooms.length == 0) {
          add(ListRoomLoad(listRooms: []));
        } else {

          add(ListRoomLoad(listRooms: rooms));
        }
      });
    } else if (event is ListRoomLoad) {
      print(event.listRooms);
      yield* mapListRoomToState(event.listRooms);
    }
  }

  Stream<ListRoomState> mapListRoomToState(List<ChatRoomInfo> rooms) async* {
    yield ListRoomLoaded(listRooms: rooms);
  }
}
