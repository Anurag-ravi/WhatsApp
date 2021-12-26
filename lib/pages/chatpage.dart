// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:whatsapp/Components/chatPage/chat_card.dart';
import 'package:whatsapp/Screens/chatPage/chat_detail.dart';
import 'package:whatsapp/Screens/chatPage/select_contact.dart';
import 'package:whatsapp/models/chat_Model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key,required this.socket}) : super(key: key);
  final IO.Socket socket;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatdata.length,
        itemBuilder: (context, index) => Column(
          children: [
            InkWell(
              child: Chatcard(
                chatmodel: chatdata[index],
              ),
              onTap: (){
                Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatDetail(
                      chatmodel: chatdata[index],
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
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => SelectContact()));
        },
        child: Icon(Icons.chat),
      ),
    );
  }
}
