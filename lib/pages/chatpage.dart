// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:whatsapp/Components/chatPage/chat_card.dart';
import 'package:whatsapp/Screens/chatPage/chat_detail.dart';
import 'package:whatsapp/Screens/chatPage/select_contact.dart';
import 'package:whatsapp/models/chat.dart';
import 'package:hive/hive.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.socket}) : super(key: key);
  final IO.Socket socket;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chats = [];
  bool loading = true;
  late Box<ChatModel> chatBox;

  @override
  void initState() {
    // TODO: implement initState
    getChats();
    super.initState();
  }

  void getChats() async {
    final box = Hive.box<ChatModel>('chats');
    List<ChatModel> temp = box.values.toList();
    temp.sort((a, b) {
      return a.epoch.compareTo(b.epoch);
    });
    setState(() {
      chats = temp;
      loading = false;
      chatBox = box;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) => Column(
                children: [
                  InkWell(
                    child: Chatcard(
                      chatmodel: chats[chats.length - 1 - index],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatDetail(
                                    chatmodel: chats[chats.length - 1 - index],
                                    socket: widget.socket,
                                  )));
                    },
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (builder) => SelectContact(
                        socket: widget.socket,
                      )));
        },
        child: Icon(Icons.chat),
      ),
    );
  }
}
