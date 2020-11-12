import 'package:chat_app/models/chat_message.dart';
import 'package:equatable/equatable.dart';

abstract class ChatRoomEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChatRoomLoad extends ChatRoomEvent {
  final String title;

  ChatRoomLoad({this.title});

  @override
  List<Object> get props => [title];
}

class SendMessage extends ChatRoomEvent {
  final ChatMessage chatMessage;
  final String title;
  SendMessage({this.chatMessage, this.title});

  @override
  List<Object> get props => [chatMessage, title];
}

class ReceiveMessage extends ChatRoomEvent {
  final List<ChatMessage> messages;

  ReceiveMessage({this.messages});

  @override
  List<Object> get props => [messages];
}