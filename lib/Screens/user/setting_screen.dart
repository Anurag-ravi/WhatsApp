// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getprefs().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> getprefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Column(
        children: [
          SizedBox(height: height * 0.015),
          Row(
            children: [
              SizedBox(width: width * 0.04),
              CircleAvatar(
                backgroundColor: Color(0xffc0c0c0),
                child: SvgPicture.asset(
                  "images/person.svg",
                  color: Colors.white,
                  width: width * 0.12,
                  height: width * 0.12,
                ),
                radius: width * 0.09,
              ),
              SizedBox(width: width * 0.04),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      prefs.getString('name').length > 13
                          ? (prefs.getString('name')).substring(0, 13) + ".."
                          : prefs.getString('name'),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    prefs.getString('status').length > 23
                        ? (prefs.getString('status')).substring(0, 23) + ".."
                        : prefs.getString('status'),
                  ),
                ],
              ),
              SizedBox(width: width * 0.05),
              Icon(
                Icons.qr_code,
                size: width * 0.09,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
          Divider(
            color: Colors.grey[300],
            height: 30,
          ),
          Row(
            children: [
              SizedBox(width: width * 0.07),
              Icon(
                Icons.lock,
                size: 25,
                color: Colors.grey,
              ),
              SizedBox(
                width: width * 0.07,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Account",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    "Privacy, security, change number",
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            children: [
              SizedBox(width: width * 0.07),
              Icon(
                Icons.chat,
                size: 25,
                color: Colors.grey,
              ),
              SizedBox(
                width: width * 0.07,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Chats",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    "Theme, wallpapers, chat history",
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            children: [
              SizedBox(width: width * 0.07),
              Icon(
                Icons.notifications,
                size: 25,
                color: Colors.grey,
              ),
              SizedBox(
                width: width * 0.07,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Notifications",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    "Message, group & call tones",
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            children: [
              SizedBox(width: width * 0.07),
              Icon(
                Icons.data_saver_off,
                size: 25,
                color: Colors.grey,
              ),
              SizedBox(
                width: width * 0.07,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Storage and data",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    "Network usage, auto download",
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            children: [
              SizedBox(width: width * 0.07),
              Icon(
                Icons.help_outline_rounded,
                size: 25,
                color: Colors.grey,
              ),
              SizedBox(
                width: width * 0.07,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Help",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    "Help center, contact us, privacy policy",
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            children: [
              SizedBox(width: width * 0.07),
              Icon(
                Icons.group,
                size: 25,
                color: Colors.grey,
              ),
              SizedBox(
                width: width * 0.07,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Invite a friend",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
            ],
          ),
          SizedBox(height: 40),
          Text("by"),
          Text(
            "@nur@g",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
