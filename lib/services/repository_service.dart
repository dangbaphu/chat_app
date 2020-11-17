import 'package:chat_app/models/chat_room_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:chat_app/models/chat_message.dart';
// import 'package:chat_app/models/chat_room_info.dart';
import 'package:chat_app/models/chat_room_info.dart';
import 'package:chat_app/models/user.dart';

class RepositoryService {
  @override

  final Firestore _firestore = Firestore.instance;
  Stream<QuerySnapshot> getChatRoomSnapshot() {
    return _firestore.collection('chat_rooms').snapshots();
  }
  Future<void> setChatRoom(ChatRoomInfo chatRoomInfo) async {
    return await _firestore
        .collection('chat_rooms')
        .document(chatRoomInfo.title)
        .setData(chatRoomInfo.toJson());
  }
  Future<User> getUser(String id) async {
    var doc = await _firestore.collection('users').document(id).get();
  
    if (doc.data != null) {
      return User(
        id: doc.data['id'],
        name: doc.data['name'],
        email: doc.data['email'],
        imgUrl: doc.data['imgUrl'],
      );
    }
    return null;
  }
  
  Future<void> registerUser(User user) async {
    _firestore.collection('users').document(user.id).setData({
      'id': user.id,
      'email': user.email,
      'name': user.name,
      'imgUrl': user.imgUrl
    });
  }

  Stream<QuerySnapshot> getChatMessages(String title) {
    return _firestore
        .collection('chat_rooms')
        .document(title)
        .collection('messages')
        .orderBy('time', descending: false)
        .limit(20)
        .snapshots();
  }

  Stream<QuerySnapshot> getMessagesAvatar() {
    return _firestore
        .collection('users')
        .snapshots();
  }

  Future<void> sendChatMessage(String title, ChatMessage chatMessage) async {
    var reference = _firestore
        .collection('chat_rooms')
        .document(title)
        .collection('messages')
        .document(chatMessage.time);

    return _firestore.runTransaction((transaction) async {
      await transaction.set(reference, {
        'message': chatMessage.message,
        'time': chatMessage.time,
        'senderId': chatMessage.senderId,
      });
    });
  }

  Future<void> setChatRoomLastMessage(
      String title, ChatMessage chatMessage) async {
    var reference = _firestore.collection('chat_rooms').document(title);

    return _firestore.runTransaction((transaction) async {
      await transaction.update(reference, {
        'lastMessage': chatMessage.message,
        'lastModified': chatMessage.time,
      });
    });
  }
}
