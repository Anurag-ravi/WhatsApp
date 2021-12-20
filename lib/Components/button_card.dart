// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({Key? key, required this.name, required this.icon})
      : super(key: key);

  final IconData icon;
  final String name;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          SizedBox(
            height: 2.5,
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xff25d366),
              child: Icon(
                icon,
                size: 22,
                color: Colors.white,
              ),
              radius: 25,
            ),
            title: Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: width * 0.045,
              ),
            ),
          ),
          SizedBox(
            height: 2.5,
          )
        ],
      ),
    );
  }
}
