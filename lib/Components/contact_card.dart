// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp/models/chat_Model.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({Key? key, required this.chatmodel}) : super(key: key);

  final ChatModel chatmodel;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return chatmodel.isGroup
        ? Container()
        : InkWell(
            onTap: () {},
            child: ListTile(
              leading: CircleAvatar(
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
                backgroundImage: chatmodel.avatar != ''
                    ? AssetImage(chatmodel.avatar)
                    : null,
                radius: 25,
              ),
              title: Text(
                chatmodel.name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: width * 0.045,
                ),
              ),
              subtitle: Text(
                chatmodel.status,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: width * 0.035,
                ),
              ),
            ),
          );
  }
}
