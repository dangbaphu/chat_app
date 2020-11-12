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

      yield ChatRoomLoading();
      chatService.getChatMessages(event.title).listen((messages) {
        chatService.getMessagesAvatar().listen((avatars) {
          print(messages[0]);
          for(var i = 0; i < messages.length; i++ ) {
            for (var j = 0; j < avatars.length; j++) {
              if (messages[i].senderId == avatars[j].id) {
                messages[i].imgUrl = avatars[j].imgUrl;
                continue;;
              }
            }
          }
          add(ReceiveMessage(messages: messages));
        });

      });
    } else if (event is ReceiveMessage) {
      yield ChatRoomLoadSuccess(messages: event.messages);
    } else if (event is SendMessage) {
      chatService.sendChatMessage(event.title, event.chatMessage);
      chatService.setChatRoomLastMessage(event.title, event.chatMessage);
    }
  }
}

