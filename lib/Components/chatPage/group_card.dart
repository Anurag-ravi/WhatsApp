// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp/models/chat.dart';

class AvatarGroup extends StatelessWidget {
  const AvatarGroup({Key? key, required this.chatmodel}) : super(key: key);

  final ChatModel chatmodel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
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
              SizedBox(
                height: 5,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 18,
                  ),
                  radius: 11,
                ),
              ),
            ],
          ),
          Text(chatmodel.name.length <= 6
              ? chatmodel.name
              : '${chatmodel.name.substring(0, 5)}..'),
        ],
      ),
    );
  }
}
