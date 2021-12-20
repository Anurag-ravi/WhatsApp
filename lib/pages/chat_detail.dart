// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp/models/chat_Model.dart';

class ChatDetail extends StatefulWidget {
  const ChatDetail({
    Key? key,
    required this.chatmodel,
  }) : super(key: key);

  final ChatModel chatmodel;

  @override
  _ChatDetailState createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        leadingWidth: 77,
        leading: Row(
          children: [
            InkWell(
              child: Icon(Icons.arrow_back),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              width: 7,
            ),
            Hero(
              tag: widget.chatmodel.id,
              child: CircleAvatar(
                backgroundColor: Color(0xffc0c0c0),
                child: widget.chatmodel.avatar == ''
                    ? SvgPicture.asset(
                        widget.chatmodel.isGroup
                            ? "images/groups.svg"
                            : "images/person.svg",
                        color: Colors.white,
                        width: 35,
                        height: 35,
                      )
                    : null,
                backgroundImage: widget.chatmodel.avatar != ''
                    ? AssetImage(widget.chatmodel.avatar)
                    : null,
                radius: 23,
              ),
            ),
          ],
        ),
        title: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.chatmodel.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                'last seen today at 18:26',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
          IconButton(onPressed: () {}, icon: Icon(Icons.call)),
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text("View Contact"),
                  value: "View Contact",
                ),
                PopupMenuItem(
                  child: Text("Media, links, and docs"),
                  value: "Media, links, and docs",
                ),
                PopupMenuItem(
                  child: Text("Search"),
                  value: "Search",
                ),
                PopupMenuItem(
                  child: Text("Mute Notifications"),
                  value: "Mute Notifications",
                ),
                PopupMenuItem(
                  child: Text("Wallpaper"),
                  value: "Wallpaper",
                ),
                PopupMenuItem(
                  child: Text("More"),
                  value: "More",
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
      body: Container(
        // padding: EdgeInsets.only(bottom: 6),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/1.jpg"),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            ListView(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Container(
                    width: width - 60,
                    child: Card(
                      margin: EdgeInsets.only(left: 6, right: 6, bottom: 7),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        minLines: 1,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type a message",
                            prefixIcon: IconButton(
                              icon: Icon(Icons.emoji_emotions_outlined),
                              onPressed: () {},
                            ),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.attach_file_outlined),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(Icons.camera_alt),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            contentPadding:
                                EdgeInsets.only(top: 5, bottom: 5, left: 10)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: IconButton(
                        icon: Icon(Icons.mic),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


// Column(
//         children: [
//           Expanded(child: Text("message")),
//           Container(
//             alignment: Alignment.bottomCenter,
//             padding: EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Flexible(
//                   child: TextFormField(
//                     minLines: 1,
//                     maxLines: 5,
//                     decoration: InputDecoration(
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(width * 0.1),
//                           borderSide:
//                               BorderSide(color: Colors.white, width: 0.0),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(width * 0.1),
//                           borderSide:
//                               BorderSide(color: Colors.white, width: 0.0),
//                         ),
//                         hintText: "Type a message"),
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),