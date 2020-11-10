// class ListRoomModel {
//   List<ChatRoomInfo> listRooms;
//
//   ListRoomModel({this.listRooms});
//   ListRoomModel.fromJson(Map<String, dynamic> json) {
//     listRooms = new List<ChatRoomInfo>();
//     json['data'].forEach((v) {
//       listRooms.add(new ChatRoomInfo.fromJson(v));
//     });
//   }
// }
//
// class ChatRoomInfo {
//   String title;
//   String imgUrl;
//   String lastMessage;
//   String lastModified;
//
//   ChatRoomInfo({this.title, this.imgUrl, this.lastMessage, this.lastModified});
//
//   ChatRoomInfo.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     imgUrl = json['imgUrl'];
//     lastMessage = json['lastMessage'];
//     lastModified = json['lastModified'];
//   }
// }

class ChatRoomInfo {
  final String title;
  final String imgUrl;
  final lastMessage;
  final lastModified;

  ChatRoomInfo({this.title, this.imgUrl, this.lastMessage, this.lastModified});

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'imgUrl': this.imgUrl,
      'lastMessage': this.lastMessage,
      'lastModified': this.lastModified,
    };
  }
}