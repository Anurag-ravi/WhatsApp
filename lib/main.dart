// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:whatsapp/pages/homepage.dart';

Future<void> main() async {
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
      home: MyHomePage(
        title: 'WhatsApp',
      ),
    );
  }
}
