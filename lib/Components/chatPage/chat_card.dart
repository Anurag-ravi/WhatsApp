// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp/Screens/chatPage/chat_detail.dart';
import 'package:whatsapp/models/chat_Model.dart';

class Chatcard extends StatelessWidget {
  const Chatcard({
    Key? key,
    required this.chatmodel,
  }) : super(key: key);
  final ChatModel chatmodel;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatDetail(
                      chatmodel: chatmodel,
                    )));
      },
      child: ListTile(
        leading: Hero(
          tag: chatmodel.id,
          child: CircleAvatar(
            backgroundColor: Color(0xffc0c0c0),
            child: chatmodel.avatar == ''
                ? SvgPicture.asset(
                    chatmodel.isGroup
                        ? "images/groups.svg"
                        : "images/person.svg",
                    color: Colors.white,
                    width: 35,
                    height: 35,
                  )
                : null,
            backgroundImage:
                chatmodel.avatar != '' ? AssetImage(chatmodel.avatar) : null,
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
              Icons.done_all_rounded,
              size: 18,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              chatmodel.message,
              style: TextStyle(
                color: Colors.grey,
                fontSize: width * 0.035,
              ),
            ),
          ],
        ),
        trailing: Text(
          chatmodel.time,
          style: TextStyle(
            color: Colors.black87,
            fontSize: width * 0.035,
          ),
        ),
      ),
    );
  }
}
