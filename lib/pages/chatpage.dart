// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whatsapp/Components/chatPage/chat_card.dart';
import 'package:whatsapp/Screens/chatPage/chat_detail.dart';
import 'package:whatsapp/Screens/chatPage/select_contact.dart';
import 'package:whatsapp/Utilities/box.dart';
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
    widget.socket.on('reply', (data) async {
      getChats();
    });
    widget.socket.on('joined', (data) async {
      getChats();
    });
    widget.socket.on('lefted', (data) async {
      getChats();
    });
    widget.socket.on('joinresponse', (data) async {
      List onlines = jsonDecode(data);
      getOnline(onlines);
      getChats();
    });
  }

  Future<void> getChats() async {
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

  Future<void> getOnline(List onlines) async {
    await openChatModelBox();
    final box = Hive.box<ChatModel>('chats');
    onlines.forEach((key) async {
      ChatModel obj = (box.get(key.toString())) as ChatModel;
      if (obj != null) {
        await box.put(
            obj.number,
            ChatModel(
                number: obj.number,
                name: obj.name,
                lastmessage: obj.lastmessage,
                status: obj.status,
                epoch: obj.epoch,
                seen: obj.seen,
                last: obj.last,
                online: true,
                time: obj.time));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: getChats,
              child: ListView.builder(
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
                                      chatmodel:
                                          chats[chats.length - 1 - index],
                                      socket: widget.socket,
                                    ))).then((value) => getChats());
                      },
                    ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
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
