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
                  Text(prefs.getString('name')),
                  Text(
                    prefs.getString('status').length > 20
                        ? (prefs.getString('status')).substring(0, 20) + ".."
                        : prefs.getString('status'),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
