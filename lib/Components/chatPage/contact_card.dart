// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp/models/chat.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({Key? key, required this.chatmodel}) : super(key: key);

  final ChatModel chatmodel;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListTile(
      leading: Container(
        height: 53,
        width: 50,
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
            // chatmodel.select
            //     ? Positioned(
            //         bottom: 2,
            //         right: 2,
            //         child: CircleAvatar(
            //           backgroundColor: Colors.teal,
            //           child: Icon(
            //             Icons.check,
            //             color: Colors.white,
            //             size: 18,
            //           ),
            //           radius: 11,
            //         ),
            //       )
            //     : Container(),
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
      subtitle: Text(
        chatmodel.status,
        style: TextStyle(
          color: Colors.grey,
          fontSize: width * 0.035,
        ),
      ),
    );
  }
}
