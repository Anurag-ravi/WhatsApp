// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp/Screens/chatPage/chat_detail.dart';
import 'package:whatsapp/models/chat.dart';

class Chatcard extends StatelessWidget {
  const Chatcard({
    Key? key,
    required this.chatmodel,
  }) : super(key: key);
  final ChatModel chatmodel;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListTile(
      leading: Hero(
        tag: chatmodel.number,
        child: Stack(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xffc0c0c0),
              child: SvgPicture.asset(
                "images/person.svg",
                color: Colors.white,
                width: 35,
                height: 35,
              ),
              radius: 25,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                radius: 6,
                backgroundColor: chatmodel.online
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.transparent,
              ),
            ),
          ],
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
          chatmodel.last
              ? Icon(
                  Icons.done_all_rounded,
                  size: 18,
                )
              : Container(),
          chatmodel.last
              ? SizedBox(
                  width: 5,
                )
              : Container(),
          Text(
            chatmodel.lastmessage,
            style: TextStyle(
              fontWeight: chatmodel.seen ? null : FontWeight.w600,
              color: Colors.grey[600],
              fontSize: width * 0.035,
            ),
          ),
        ],
      ),
      trailing: chatmodel.seen
          ? Text(
              chatmodel.time,
              style: TextStyle(
                color: Colors.black87,
                fontSize: width * 0.035,
              ),
            )
          : Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(3),
              ),
              padding: EdgeInsets.all(3),
              child: Text(
                chatmodel.time,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: width * 0.035,
                ),
              ),
            ),
    );
  }
}
