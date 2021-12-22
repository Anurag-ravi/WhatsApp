// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class TheirMessage extends StatelessWidget {
  const TheirMessage({Key? key, required this.message, required this.time})
      : super(key: key);

  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: width * 0.8,
          minWidth: width * 0.3,
        ),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
          color: Color(0xffffffff),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 5, left: 10, right: 10, bottom: 20),
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: message.length < 3 ? width * 0.06 : width * 0.042,
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Text(
                  time,
                  style: TextStyle(
                    fontSize: width * 0.033,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
