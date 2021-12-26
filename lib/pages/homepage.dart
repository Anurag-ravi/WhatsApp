// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/Screens/user/setting_screen.dart';
import 'package:whatsapp/data.dart';
import 'package:whatsapp/pages/calls_page.dart';
import 'package:whatsapp/pages/camera_page.dart';
import 'package:whatsapp/pages/chatpage.dart';
import 'package:whatsapp/pages/status_page.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.prefs})
      : super(key: key);

  final String title;
  final SharedPreferences prefs;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  late IO.Socket socket;

  @override
  void initState() {
    _tabController = TabController(length: 4, initialIndex: 1, vsync: this)
      ..addListener(() {
        setState(() {});
      });
      connect();
    super.initState();
  }

  void connect() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    socket = IO.io(url,<String,dynamic>{
      "transports":["websocket"],
      "autoConnect":false,
    });
    socket.connect();
    socket.onConnect((_) {
      print("===connected===");
      socket.emit("join",prefs.getString('fullNumber'));
    });
    setState(() {
      
    });
      socket.on('reply', (data) => print(data));
      socket.onDisconnect((_) => print('disconnect'));
      // socket.on('fromServer', (_) => print(_));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          title: Text(widget.title),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text("New group"),
                    value: "New group",
                  ),
                  PopupMenuItem(
                    child: Text("New broadcast"),
                    value: "New broadcast",
                  ),
                  PopupMenuItem(
                    child: Text("Linked devices"),
                    value: "Linked devices",
                  ),
                  PopupMenuItem(
                    child: Text("Starred messages"),
                    value: "Starred messages",
                  ),
                  PopupMenuItem(
                    child: Text("Payments"),
                    value: "Payments",
                  ),
                  PopupMenuItem(
                    child: Text("Settings"),
                    value: "Settings",
                  ),
                ];
              },
              onSelected: (value) {
                print(value);
                if (value == "Settings") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => SettingsScreen()));
                }
              },
              elevation: 5.0,
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            controller: _tabController,
            tabs: [
              Icon(Icons.camera_alt),
              Container(
                width: width * 0.193,
                alignment: Alignment.center,
                child: Text("CHATS"),
              ),
              Container(
                width: width * 0.193,
                alignment: Alignment.center,
                child: Text("STATUS"),
              ),
              Container(
                width: width * 0.193,
                alignment: Alignment.center,
                child: Text("CALLS"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            // CameraPage(cameras: widget.cameras),
            CameraPage(),
            ChatPage(socket: socket,),
            StatusPage(),
            CallsPage(),
          ],
        ));
  }
}
