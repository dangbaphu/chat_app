import 'dart:math';

import 'package:chat_app/models/chat_message.dart';
import 'package:chat_app/services/repository_service.dart';
// import 'package:meta/meta.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/models/chat_room_info.dart';
import 'package:chat_app/locator.dart';

class ChatService {
    RepositoryService _repository = locator<RepositoryService>();

    Future<void> addChatList(String title) async {
        ChatRoomInfo newRoomInfo = ChatRoomInfo(
          imgUrl: 'https://images.unsplash.com/photo-1577563908411-5077b6dc7624?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80',
          title: title,
          lastMessage: '',
          lastModified: DateTime.now().millisecondsSinceEpoch.toString(),
        );
        await _repository.setChatRoom(newRoomInfo);
    }

    Stream<List<ChatRoomInfo>> getChatRooms() {
      return _repository.getChatRoomSnapshot().transform(documentToChatRoomsTransformer);
    }

    StreamTransformer documentToChatRoomsTransformer = StreamTransformer<QuerySnapshot, List<ChatRoomInfo>>.fromHandlers(
        handleData: (QuerySnapshot snapShot, EventSink<List<ChatRoomInfo>> sink) {
          List<ChatRoomInfo> result = new List<ChatRoomInfo>();
          snapShot.documents.forEach((doc) {
            result.add(ChatRoomInfo(
              title: doc['title'],
              imgUrl: doc['imgUrl'],
              lastModified: doc['lastModified'],
              lastMessage: doc['lastMessage'],
            ));
          });
          sink.add(result);
        }
    );

    Stream<List<ChatMessage>> getChatMessages(String title) {
      return _repository.getChatMessages(title).transform(documentToChatMessagesTransformer);
    }

    StreamTransformer documentToChatMessagesTransformer = StreamTransformer<QuerySnapshot, List<ChatMessage>>.fromHandlers(
        handleData: (QuerySnapshot snapShot, EventSink<List<ChatMessage>> sink) {
          List<ChatMessage> result = new List<ChatMessage>();
          snapShot.documents.forEach((doc) {
            result.add(ChatMessage(
                message: doc['message'],
                senderId: doc['senderId'],
                time: doc['time']
            ));
          });
          sink.add(result);
        }
    );

    Stream<List<MessageAvatar>> getMessagesAvatar() {
      return _repository.getMessagesAvatar().transform(documentToMessagesAvatarTransformer);
    }
    StreamTransformer documentToMessagesAvatarTransformer = StreamTransformer<QuerySnapshot, List<MessageAvatar>>.fromHandlers(
        handleData: (QuerySnapshot snapShot, EventSink<List<MessageAvatar>> sink) {
          List<MessageAvatar> result = new List<MessageAvatar>();
          snapShot.documents.forEach((doc) {
            result.add(MessageAvatar(
              id: doc['id'],
              imgUrl: doc['imgUrl']
            ));
            result.add(MessageAvatar(
                id: doc['id'],
            ));
          });
          sink.add(result);
        }
    );

    Future<void> sendChatMessage(String title, ChatMessage chatMessage) async {
      return await _repository.sendChatMessage(title, chatMessage);
    }

    Future<void> setChatRoomLastMessage(String title, ChatMessage chatMessage) async {
      return await _repository.setChatRoomLastMessage(title, chatMessage);
    }

}

class MessageAvatar {
  final String id;
  final String imgUrl;

  MessageAvatar({this.id, this.imgUrl});

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'imgUrl': this.imgUrl
    };
  }
}

var chatService = ChatService();
