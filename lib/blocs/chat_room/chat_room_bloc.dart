import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/blocs/chat_room/chat_room_event.dart';
import 'package:chat_app/blocs/chat_room/chat_room_state.dart';
import 'package:chat_app/services/chat_service.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  final User user;
  ChatRoomBloc({this.user}) : super(ChatRoomInitial());

  @override
  Stream<ChatRoomState> mapEventToState(
    ChatRoomEvent event,
  ) async* {
    if (event is ChatRoomLoad) {
      print(event.title);
      yield ChatRoomLoading();
      chatService.getChatMessages(event.title).listen((messages) {
        add(ReceiveMessage(messages: messages));
      });
    } else if (event is ReceiveMessage) {
      yield ChatRoomLoadSuccess(messages: event.messages);
    } else if (event is SendMessage) {
      chatService.sendChatMessage(event.title, event.chatMessage);
      chatService.setChatRoomLastMessage(event.title, event.chatMessage);
    }
  }
}
