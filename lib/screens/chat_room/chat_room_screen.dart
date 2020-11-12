import 'package:chat_app/blocs/chat_room/chat_room_bloc.dart';
import 'package:chat_app/blocs/chat_room/chat_room_event.dart';
import 'package:chat_app/screens/list_room/list_room_screen.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/blocs/chat_room/chat_room_state.dart';
import 'package:chat_app/models/chat_message.dart';
import 'package:chat_app/models/chat_room_info.dart';
import 'package:chat_app/models/user.dart';
// import 'package:chat_app/screens/chat_room/chat_message_input.dart';
import 'package:chat_app/screens/chat_room/chat_message_item.dart';

class ChatRoomScreen extends StatefulWidget {
  final User user;
  final ChatRoomInfo chatRoomInfo;

  const ChatRoomScreen({Key key, this.user, this.chatRoomInfo}) : super(key: key);
  @override
  _ChatRoomState createState() => _ChatRoomState();
}
class _ChatRoomState extends State<ChatRoomScreen> {
  final TextEditingController _controller = TextEditingController();
  ChatRoomBloc _chatRoomBloc;

  @override
  void initState() {
    _chatRoomBloc = BlocProvider.of<ChatRoomBloc>(context);
    _chatRoomBloc.add(ChatRoomLoad(title: widget.chatRoomInfo.title));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffcf3f4),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          widget.chatRoomInfo.title,
          style: TextStyle(
            fontSize: 22,
            color: Color(0xff6a515e),
            fontWeight: FontWeight.w300,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: BlocBuilder<ChatRoomBloc, ChatRoomState>(
        builder: (context, state) {
          if (state is ChatRoomLoadSuccess) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      reverse: true,
                      child: Column(
                        children: <Widget>[
                          for (var i = 0; i < state.messages.length; i++)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: ChatMessageItem(
                                user: widget.user,
                                chat: state.messages[i],
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: 'Please enter the message',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: Constants.border,
                              disabledBorder: Constants.border,
                              border: Constants.border,
                              errorBorder: Constants.border,
                              focusedBorder: Constants.border,
                              focusedErrorBorder: Constants.border,
                            ),

                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            _chatRoomBloc.add(SendMessage(
                                chatMessage: ChatMessage(
                                  senderId: widget.user.id,
                                  message: _controller.text,
                                  time: DateTime.now().millisecondsSinceEpoch.toString()
                              ),title: widget.chatRoomInfo.title));
                            _controller.clear();
                          },
                          padding: EdgeInsets.zero,
                          shape: CircleBorder(),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                    colors: [Color(0xffffae88), Color(0xff8f93ea)]
                                )
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: Text('Loading'),
            );
          }
        },
      ),
    );
  }
}