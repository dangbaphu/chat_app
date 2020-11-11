import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/locator.dart';
import 'package:chat_app/models/chat_room_info.dart';
import 'package:chat_app/services/repository_service.dart';

class ChatService {
  RepositoryService _repositoryService = locator<RepositoryService>();

  Future<void> addChatList(String id, String title) async {
    var chatRoomInfo = await _repositoryService.getChatRoom(title);

    if (chatRoomInfo.exists) {
      return _repositoryService.updateUserChatList(id, title);
    } else {
      ChatRoomInfo newRoomInfo = ChatRoomInfo(
        imgUrl: 'https://images.unsplash.com/photo-1577563908411-5077b6dc7624?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80',
        title: title,
        lastMessage: '',
        lastModified: DateTime.now().millisecondsSinceEpoch.toString(),
      );

      await _repositoryService.setChatRoom(newRoomInfo);
      await _repositoryService.updateUserChatList(id, title);
    }
  }

  Stream<List<ChatRoomInfo>> getChatRoomInfo(List<String> chatTitles) {
    return _repositoryService.getChatRoomInfo(chatTitles).transform(documentToChatRoomInfoTransformer);
  }

  StreamTransformer documentToChatRoomInfoTransformer = StreamTransformer<QuerySnapshot, List<ChatRoomInfo>>.fromHandlers(
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

  Stream<List<String>> getChatList(String id) {
    return _repositoryService.getChatList(id).transform(documentToChatListTransformer);
  }

  StreamTransformer documentToChatListTransformer = StreamTransformer<DocumentSnapshot, List<String>>.fromHandlers(
    handleData: (DocumentSnapshot snapShot, EventSink<List<String>> sink) {
      if (snapShot.exists) {
        sink.add(snapShot.data.keys.toList());
      } else {
        sink.add([]);
      }
    }
  );
}