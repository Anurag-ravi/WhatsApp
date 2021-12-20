// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:whatsapp/Components/chat_card.dart';
import 'package:whatsapp/models/chat_Model.dart';
import 'package:whatsapp/pages/chat_detail.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView.builder(
        itemCount: chatdata.length,
        itemBuilder: (context, index) => Column(
          children: [
            // ListTile(
            //   leading: Hero(
            //     tag: chatdata[index].id,
            //     child: CircleAvatar(
            //       backgroundColor: Colors.blue,
            //       backgroundImage: AssetImage(chatdata[index].avatar),
            //       radius: width * 0.075,
            //     ),
            //   ),
            //   title: Text(
            //     chatdata[index].name,
            //     style: TextStyle(
            //       fontWeight: FontWeight.w600,
            //       fontSize: width * 0.045,
            //     ),
            //   ),
            //   subtitle: Text(
            //     chatdata[index].message,
            //     style: TextStyle(
            //       color: Colors.grey,
            //       fontSize: width * 0.035,
            //     ),
            //   ),
            //   trailing: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         chatdata[index].time,
            //         style: TextStyle(
            //           color: Colors.black87,
            //           fontSize: width * 0.035,
            //         ),
            //       ),
            //       SizedBox(
            //         height: width * 0.025,
            //       ),
            //       Flexible(
            //         child: CircleAvatar(
            //           radius: width * 0.028,
            //           backgroundColor: Theme.of(context).colorScheme.secondary,
            //           child: Text(
            //             '4',
            //             style: TextStyle(
            //                 color: Colors.white, fontSize: width * 0.04),
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => ChatDetail(
            //                   tag: chatdata[index].id,
            //                   img: chatdata[index].avatar,
            //                   name: chatdata[index].name,
            //                 )));
            //   },
            // ),
            Chatcard(
              chatmodel: chatdata[index],
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.chat),
      ),
    );
  }
}
