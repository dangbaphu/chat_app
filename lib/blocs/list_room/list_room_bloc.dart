import 'package:bloc/bloc.dart';
import 'package:chat_app/blocs/list_room/list_room_event.dart';
import 'package:chat_app/blocs/list_room/list_room_state.dart';
import 'package:chat_app/services/repository_service.dart';
import 'package:meta/meta.dart';
import 'package:chat_app/models/chat_room_info.dart';

class ListRoomBloc extends Bloc<ListRoomEvent, ListRoomState> {
  RepositoryService repository;

  ListRoomBloc({@required this.repository});


  @override
  // TODO: implement initialState
  ListRoomState get initialState => ListRoomInitial();

  @override
  Stream<ListRoomState> mapEventToState(ListRoomEvent event) async* {
    if (event is ListRoomEvent) {
      yield ListRoomLoading();
      try {
        List<ChatRoomInfo> listRooms = await repository.getChatRoom();
        yield ListRoomLoaded(listRooms: listRooms);
      } catch (e) {
        yield ListRoomError(message: e.toString());
      }
    }
  }

}
