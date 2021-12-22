// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:whatsapp/Components/StatusPage/other_status_card.dart';
import 'package:whatsapp/Components/StatusPage/own_status_card.dart';
import 'package:whatsapp/models/chat_Model.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 50,
            child: FloatingActionButton(
              backgroundColor: Colors.blueGrey[100],
              child: Icon(
                Icons.edit,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: Icon(Icons.camera_alt),
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Ownstatus(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              height: 25,
              width: width,
              color: Colors.grey[200],
              child: Text(
                "Recent updates",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            OtherStatus(
              viewed: false,
              chatmodel: chatdata[1],
              statusNum: 1,
            ),
            OtherStatus(
              viewed: false,
              chatmodel: chatdata[2],
              statusNum: 3,
            ),
            OtherStatus(
              viewed: false,
              chatmodel: chatdata[3],
              statusNum: 2,
            ),
            OtherStatus(
              viewed: false,
              chatmodel: chatdata[4],
              statusNum: 5,
            ),
            OtherStatus(
              viewed: false,
              chatmodel: chatdata[5],
              statusNum: 4,
            ),
            OtherStatus(
              viewed: false,
              chatmodel: chatdata[6],
              statusNum: 7,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              height: 25,
              width: width,
              color: Colors.grey[200],
              child: Text(
                "viewed updates",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            OtherStatus(
              viewed: true,
              chatmodel: chatdata[7],
              statusNum: 2,
            ),
            OtherStatus(
              viewed: true,
              chatmodel: chatdata[9],
              statusNum: 4,
            ),
            OtherStatus(
              viewed: true,
              chatmodel: chatdata[10],
              statusNum: 3,
            ),
            OtherStatus(
              viewed: true,
              chatmodel: chatdata[11],
              statusNum: 1,
            ),
            OtherStatus(
              viewed: true,
              chatmodel: chatdata[12],
              statusNum: 6,
            ),
          ],
        ),
      ),
    );
  }
}
