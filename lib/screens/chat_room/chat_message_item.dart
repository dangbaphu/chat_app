import 'package:chat_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/models/chat_message.dart';

class ChatMessageItem extends StatelessWidget {
  final User user;
  final ChatMessage chat;

  const ChatMessageItem({Key key, this.user, this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMe = user.id == chat.senderId;
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        isMe ? Container() : buildAvatar(user),
        buildMessage(context, isMe, chat)
      ],
    );
  }
}

Widget buildAvatar(User user) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: CircleAvatar(
          radius: 18,
          backgroundImage: NetworkImage(
            user.imgUrl,
          ),
        ),
      ),
    ),
  );
}

Widget buildMessage(context, isMe, chat) {
  return Container(
    padding: const EdgeInsets.all(8),
    margin: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
        color: isMe ? Theme.of(context).accentColor : Theme.of(context).primaryColor,
        borderRadius: isMe ? BorderRadius.only(
          topRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
        ) : BorderRadius.only(
          topRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        )
    ),
    constraints: BoxConstraints(
      maxWidth: MediaQuery.of(context).size.width * 0.65,
      minHeight: 30,
    ),
    child: Text(chat.message, style: TextStyle(
      color: isMe ? Colors.white : Colors.black,
    ),),
  );
}