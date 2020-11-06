import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/models/user.dart';

class RepositoryService {
  final Firestore _firestore = Firestore.instance;

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
}
