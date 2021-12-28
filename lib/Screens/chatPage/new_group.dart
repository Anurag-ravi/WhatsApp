// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:whatsapp/Components/chatPage/contact_card.dart';
import 'package:whatsapp/Components/chatPage/group_card.dart';
import 'package:whatsapp/models/chat.dart';

class NewGroup extends StatefulWidget {
  const NewGroup({Key? key}) : super(key: key);

  @override
  _NewGroupState createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {
  List<ChatModel> chatData = [];
  List<ChatModel> groupMembers = [];

  @override
  void initState() {
    // TODO: implement initState
    // chatData = chatdata;
    // setState(() {
    //   chatData = chatdata;
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Group",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
            ),
            Text(
              groupMembers.length > 0
                  ? "${groupMembers.length} Participants"
                  : "Add Participants",
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text("Invite a friend"),
                  value: "Invite a friend",
                ),
                PopupMenuItem(
                  child: Text("Contacts"),
                  value: "Contacts",
                ),
                PopupMenuItem(
                  child: Text("Refresh"),
                  value: "Refresh",
                ),
                PopupMenuItem(
                  child: Text("Help"),
                  value: "Help",
                ),
              ];
            },
            onSelected: (value) {
              print(value);
            },
            elevation: 5.0,
          ),
        ],
      ),
      body: Stack(
        children: [
          // ListView.builder(
          //   padding: groupMembers.length > 0
          //       ? EdgeInsets.only(top: 80)
          //       : EdgeInsets.all(0),
          //   itemCount: chatData.length,
          //   itemBuilder: (context, index) {
          //     return InkWell(
          //       child: ContactCard(chatmodel: chatData[index]),
          //       onTap: () {
          //         if (chatData[index].select == false) {
          //           setState(() {
          //             chatData[index].select = true;
          //             groupMembers.add(chatData[index]);
          //           });
          //         } else {
          //           setState(() {
          //             chatData[index].select = false;
          //             groupMembers.remove(chatData[index]);
          //           });
          //         }
          //       },
          //     );
          //   },
          // ),
          groupMembers.length > 0
              ? Column(
                  children: [
                    Container(
                      height: 75,
                      color: Colors.white,
                      child: ListView.builder(
                        itemCount: chatData.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          // return chatData[index].select
                          //     ? InkWell(
                          //         child: AvatarGroup(
                          //           chatmodel: chatData[index],
                          //         ),
                          //         onTap: () {
                          //           setState(() {
                          //             groupMembers.remove(chatData[index]);
                          //             chatData[index].select = false;
                          //           });
                          //         },
                          //       )
                          return Container();
                        },
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    )
                  ],
                )
              : Container(),
        ],
      ),
      floatingActionButton: groupMembers.length > 0
          ? FloatingActionButton(
              onPressed: () {},
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(Icons.arrow_forward),
            )
          : null,
    );
  }
}
