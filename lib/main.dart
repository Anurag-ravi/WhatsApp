// ignore_for_file: prefer_const_constructors
import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:whatsapp/Screens/InitialSceens/landing_screen.dart';
import 'package:whatsapp/Screens/cameraPage/camera_screen.dart';
import 'package:whatsapp/models/chat.dart';
import 'package:whatsapp/models/contactmodel.dart';
import 'package:whatsapp/models/message.dart';
import 'package:whatsapp/pages/homepage.dart';

late SharedPreferences prefs;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  prefs = await SharedPreferences.getInstance();
  Hive.registerAdapter(ContactModelAdapter());
  Hive.registerAdapter(ChatModelAdapter());
  Hive.registerAdapter(MessageModelAdapter());
  await Hive.initFlutter();

  await Hive.openBox<ContactModel>('contacts');
  await Hive.openBox<ChatModel>('chats');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp',
      theme: ThemeData(
        fontFamily: "OpenSans",
        colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: const Color(0xff25d366),
            primary: const Color(0xff075e54)),
      ),
      debugShowCheckedModeBanner: false,
      home: prefs.getString('fullNumber') == null
          ? LandingScreen()
          : MyHomePage(
              title: "WhatsApp Clone",
              prefs: prefs,
            ),
    );
  }
}
