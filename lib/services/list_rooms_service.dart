import 'package:chat_app/services/repository_service.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/models/chat_room_info.dart';
import 'package:chat_app/locator.dart';

class ListRoomsService {
    RepositoryService repository = locator<RepositoryService>();
    Stream<List<ChatRoomInfo>> getChatRooms() {
      return repository.getChatRoomSnapshot().transform(documentToChatRoomsTransformer);
    }

    StreamTransformer documentToChatRoomsTransformer = StreamTransformer<QuerySnapshot, List<ChatRoomInfo>>.fromHandlers(
        handleData: (QuerySnapshot snapShot, EventSink<List<ChatRoomInfo>> sink) {
          print(snapShot);
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


    //   var chatRoomInfo = await _repositoryService.getChatRoom(title);
  //
  //   if (chatRoomInfo.exists) {
  //     return _repositoryService.updateUserChatList(id, title);
  //   } else {
  //     ChatRoomInfo newRoomInfo = ChatRoomInfo(
  //       imgUrl: 'https://images.unsplash.com/photo-1577563908411-5077b6dc7624?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80',
  //       title: title,
  //       lastMessage: '',
  //       lastModified: DateTime
  //           .now()
  //           .millisecondsSinceEpoch
  //           .toString(),
  //     );
  //
  //     await _repositoryService.setChatRoom(newRoomInfo);
  //     await _repositoryService.updateUserChatList(id, title);
  //   }
  // }
  //
  // Stream<List<ChatRoomInfo>> getChatRoomInfo(List<String> chatTitles) {
  //   return _repositoryService.getChatRoomInfo(chatTitles).transform(
  //       documentToChatRoomInfoTransformer);
  // }
}