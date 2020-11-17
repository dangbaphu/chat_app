class ChatRoomInfo {
  final String userCreate;
  final String title;
  final String password;
  final String imgUrl;
  final lastMessage;
  final lastModified;

  ChatRoomInfo({this.userCreate, this.title, this.password, this.imgUrl, this.lastMessage, this.lastModified});

  Map<String, dynamic> toJson() {
    return {
      'userCreate': this.userCreate,
      'title': this.title,
      'password': this.password,
      'imgUrl': this.imgUrl,
      'lastMessage': this.lastMessage,
      'lastModified': this.lastModified,
    };
  }
}