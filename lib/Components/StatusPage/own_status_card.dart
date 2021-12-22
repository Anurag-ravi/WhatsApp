// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class Ownstatus extends StatelessWidget {
  const Ownstatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 27,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage("images/1.jpg"),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Stack(
              alignment: Alignment(0, 0),
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white,
                ),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Icon(
                    Icons.add,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      title: Text(
        "My Status",
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        "Tap to add Status",
        style: TextStyle(
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
