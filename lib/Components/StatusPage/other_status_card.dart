// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp/models/chat.dart';

class OtherStatus extends StatelessWidget {
  const OtherStatus(
      {Key? key,
      required this.viewed,
      required this.chatmodel,
      required this.statusNum})
      : super(key: key);

  final bool viewed;
  final int statusNum;
  final ChatModel chatmodel;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 70,
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomPaint(
            painter: StatusPainter(isSeen: viewed, statusNum: statusNum),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Color(0xffc0c0c0),
              child: SvgPicture.asset(
                "images/person.svg",
                color: Colors.white,
                width: 35,
                height: 35,
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chatmodel.name,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              Text(
                "28 minutes ago",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget Status(BuildContext context) {
    return Stack(
      alignment: Alignment(0, 0),
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: viewed
                ? Colors.grey[300]
                : Theme.of(context).colorScheme.secondary,
          ),
        ),
        Container(
          width: 56,
          height: 56,
          child: CircleAvatar(
            backgroundColor: Colors.white,
          ),
        ),
        Container(
          width: 52,
          height: 52,
          child: CircleAvatar(
              backgroundColor: Color(0xffc0c0c0),
              child: SvgPicture.asset(
                "images/person.svg",
                color: Colors.white,
                width: 35,
                height: 35,
              )),
        ),
      ],
    );
  }
}

degreeToRadian(double degree) {
  return degree * pi / 180;
}

class StatusPainter extends CustomPainter {
  bool isSeen;
  int statusNum;

  StatusPainter({required this.isSeen, required this.statusNum});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint1 = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 8.5
      ..color = (isSeen ? Colors.grey[300] : Color(0xff25d366))!
      ..style = PaintingStyle.stroke;
    final Paint paint2 = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 4.0
      ..color = Color(0xffffffff)
      ..style = PaintingStyle.stroke;

    drawarc(canvas, size, paint1);
    canvas.drawArc(Rect.fromLTWH(0.0, 0.0, size.width, size.height),
        degreeToRadian(0), degreeToRadian(360), false, paint2);
  }

  void drawarc(Canvas canvas, Size size, Paint paint) {
    if (statusNum == 1) {
      canvas.drawArc(Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          degreeToRadian(0), degreeToRadian(360), false, paint);
    } else {
      double degree = -90;
      double arc = 360 / statusNum;
      for (int i = 0; i < statusNum; i++) {
        canvas.drawArc(Rect.fromLTWH(0.0, 0.0, size.width, size.height),
            degreeToRadian(degree + 4), degreeToRadian(arc - 8), false, paint);
        degree += arc;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
