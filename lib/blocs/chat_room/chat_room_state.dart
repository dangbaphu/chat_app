import 'package:chat_app/models/chat_message.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ChatRoomState extends Equatable {
  @override
  List<Object> get props => [];
}

class ChatRoomInitial extends ChatRoomState {}

class ChatRoomLoading extends ChatRoomState {}

class ChatRoomLoadSuccess extends ChatRoomState {
  final List<ChatMessage> messages;

  ChatRoomLoadSuccess({this.messages});

  @override
  List<Object> get props => [messages];
}

class ChatRoomLoadError extends ChatRoomState {}