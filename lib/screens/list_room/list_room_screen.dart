import 'package:chat_app/blocs/list_room/list_room_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/blocs/list_room/list_room_bloc.dart';
import 'package:chat_app/blocs/list_room/list_room_state.dart';
import 'package:chat_app/models/chat_room_info.dart';

class ListRoomScreen extends StatefulWidget {
  @override
  _ListRoomState createState() => _ListRoomState();
}

class _ListRoomState extends State<ListRoomScreen> {
  ListRoomBloc _listRoomBloc;

  @override
  void initState() {
    _listRoomBloc = BlocProvider.of<ListRoomBloc>(context);
    _listRoomBloc.add(ListRoomStart());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffcf3f4),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Chat rooms',
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
      floatingActionButton: Align(
        alignment: Alignment(1, 0.85),
        child: FloatingActionButton(
          onPressed: () {
            _showDialog(context);
          },
          child: Container(
            width: 60,
            height: 60,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [Color(0xffffae88), Color(0xff8f93ea)])),
          ),
        ),
      ),
      body:
           BlocBuilder<ListRoomBloc, ListRoomState>(
             builder: (context, state) {
               if (state is ListRoomInitial) {
                 return buildLoading();
               } else if (state is ListRoomLoading) {
                 return buildLoading();
               } else if (state is ListRoomLoaded) {
                 return buildListRooms(state.listRooms);
               } else if (state is ListRoomError) {
                 return buildErrorUi(state.message);
               }

             }
           ),
    );
  }
  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }


  Widget buildListRooms(List<ChatRoomInfo> listRooms) {
    return Container(
      child: ListView.builder(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 60),
          itemCount: listRooms.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image.network(listRooms[index].imgUrl),
              title: Text('${listRooms[index].title}'),
            );
          }),
    );
  }

  // Widget _chatListLoading(context, state) {
  //   if (state is ChatListLoadSuccess) {
  //     return Expanded(
  //       child: ListView.builder(
  //         padding: const EdgeInsets.only(left: 20, right: 20, bottom: 60),
  //         itemBuilder: (context, index) {
  //           return GestureDetector(
  //             onTap: () {
  //               Navigator.of(context).push(MaterialPageRoute(builder: (_) {
  //                 return BlocProvider(
  //                   create: (_) => ChatRoomBloc(user: user, title: state.chatList[index].title)..add(ChatRoomLoad()),
  //                   child: ChatRoomScreen(
  //                     user: user,
  //                     chatRoomInfo: state.chatList[index],
  //                   ),
  //                 );
  //               }));
  //             },
  //             child: Padding(
  //               padding: const EdgeInsets.only(bottom: 10),
  //               child: ChatListItem(
  //                 chatRoomInfo: state.chatList[index],
  //               ),
  //             ),
  //           );
  //         },
  //         itemCount: state.chatList.length,
  //       ),
  //     );
  //   } else {
  //     return Center(
  //       child: Text('Loading'),
  //     );
  //   }
  // }

  Widget _showDialog(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Add ChatRoom'),
            content: TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'ChatRoom Title',
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.pop(_);
                },
              ),
              FlatButton(
                child: Text('Done'),
                onPressed: () {
                  _listRoomBloc.add(AddChatRoom(title: _controller.text));
                  Navigator.pop(_);
                },
              )
            ],
          );
        });
  }
}
