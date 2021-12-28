// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp/models/chat.dart';

class CallsPage extends StatefulWidget {
  const CallsPage({Key? key}) : super(key: key);

  @override
  _CallsPageState createState() => _CallsPageState();
}

class _CallsPageState extends State<CallsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // callCard(chatdata[0], true, 2),
          // callCard(chatdata[1], false, 1),
          // callCard(chatdata[2], false, 3),
          // callCard(chatdata[3], true, 1),
          // callCard(chatdata[4], true, 1),
          // callCard(chatdata[5], false, 2),
          // callCard(chatdata[6], false, 3),
          // callCard(chatdata[7], true, 3),
          // callCard(chatdata[11], true, 2),
          // callCard(chatdata[9], false, 1),
          // callCard(chatdata[12], false, 3),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_call),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  Widget callCard(ChatModel chatmodel, bool isVideoCall, int comeStatus) {
    double width = MediaQuery.of(context).size.width;
    return ListTile(
        leading: Hero(
          tag: chatmodel.number,
          child: CircleAvatar(
            backgroundColor: Color(0xffc0c0c0),
            child: SvgPicture.asset(
              "images/person.svg",
              color: Colors.white,
              width: 35,
              height: 35,
            ),
            radius: 25,
          ),
        ),
        title: Text(
          chatmodel.name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: width * 0.045,
          ),
        ),
        subtitle: Row(
          children: [
            Icon(
              comeStatus == 3
                  ? Icons.call_missed_rounded
                  : comeStatus == 2
                      ? Icons.call_received_rounded
                      : Icons.call_made_rounded,
              size: 18,
              color: comeStatus == 3
                  ? Colors.red
                  : Theme.of(context).colorScheme.secondary,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Today, 10:14 AM",
              style: TextStyle(
                color: Colors.grey,
                fontSize: width * 0.035,
              ),
            ),
          ],
        ),
        trailing: Icon(
          isVideoCall ? Icons.videocam_rounded : Icons.call,
          color: Theme.of(context).colorScheme.primary,
          size: 30,
        ));
  }
}
