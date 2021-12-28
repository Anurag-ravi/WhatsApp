// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/Components/chatPage/our_message.dart';
import 'package:whatsapp/Components/chatPage/their_message.dart';
import 'package:whatsapp/models/chat.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatDetail extends StatefulWidget {
  const ChatDetail({
    Key? key,
    required this.chatmodel,
    required this.socket,
  }) : super(key: key);

  final ChatModel chatmodel;
  final IO.Socket socket;

  @override
  _ChatDetailState createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  bool show = false;
  bool icon = false;
  FocusNode focusnode = FocusNode();
  TextEditingController _controller = TextEditingController();
  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusnode.addListener(() {
      if (focusnode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
    init();
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Image.asset(
          "images/wallpaper.png",
          height: height,
          width: width,
          fit: BoxFit.fitHeight,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
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
                  tag: widget.chatmodel.number,
                  child: CircleAvatar(
                    backgroundColor: Color(0xffc0c0c0),
                    child: SvgPicture.asset(
                      "images/person.svg",
                      color: Colors.white,
                      width: 35,
                      height: 35,
                    ),
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
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Stack(
                children: [
                  Container(
                    height: height - 145,
                    child: ListView(
                      children: [
                        OurMessage(
                          message: "Hi ${widget.chatmodel.name}....",
                          time: "18:26",
                        ),
                        TheirMessage(
                          message: "Hi Anurag",
                          time: "18:27",
                        ),
                        OurMessage(
                          message: "See I made this Whatsapp Clone",
                          time: "18:28",
                        ),
                        OurMessage(
                          message: "Using Flutter and Dart 😍",
                          time: "18:28",
                        ),
                        TheirMessage(
                          message: "🔥🔥 wow..",
                          time: "18:29",
                        ),
                        OurMessage(
                          message: "you liked it?..",
                          time: "18:30",
                        ),
                        TheirMessage(
                          message: "Yes..",
                          time: "18:31",
                        ),
                        TheirMessage(
                          message: "Its awesome..😍😎",
                          time: "18:31",
                        ),
                        OurMessage(
                          message: "😎",
                          time: "18:32",
                        ),
                        OurMessage(
                          message: "Thank you..😊😊",
                          time: "18:32",
                        ),
                        OurMessage(
                          message:
                              "I am willing to add more features in this app..",
                          time: "18:33",
                        ),
                        TheirMessage(
                          message: "Ohh 😀",
                          time: "18:34",
                        ),
                        TheirMessage(
                          message: "can you tell me some of the features...",
                          time: "18:35",
                        ),
                        OurMessage(
                          message: "Khud app chla k dekh le 😂😂",
                          time: "18:35",
                        ),
                        TheirMessage(
                          message: "😏😏",
                          time: "18:36",
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: width - 60,
                                child: Card(
                                  margin: EdgeInsets.only(
                                      left: 6, right: 6, bottom: 7),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: TextFormField(
                                    controller: _controller,
                                    focusNode: focusnode,
                                    onChanged: (text) {
                                      if (text.isNotEmpty) {
                                        setState(() {
                                          icon = true;
                                        });
                                      } else {
                                        setState(() {
                                          icon = false;
                                        });
                                      }
                                    },
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Type a message",
                                        prefixIcon: IconButton(
                                          icon: Icon(
                                              Icons.emoji_emotions_outlined),
                                          onPressed: () {
                                            setState(() {
                                              focusnode.unfocus();
                                              focusnode.canRequestFocus = false;
                                              show = !show;
                                            });
                                          },
                                        ),
                                        suffixIcon: icon
                                            ? null
                                            : Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(Icons
                                                        .attach_file_outlined),
                                                    onPressed: () {
                                                      setState(() {
                                                        show = false;
                                                      });
                                                      showModalBottomSheet(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          context: context,
                                                          builder: (builder) =>
                                                              bottomPop());
                                                    },
                                                  ),
                                                  IconButton(
                                                    icon:
                                                        Icon(Icons.camera_alt),
                                                    onPressed: () {},
                                                  ),
                                                ],
                                              ),
                                        contentPadding: EdgeInsets.only(
                                            top: 5, bottom: 5, left: 10)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 7),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  child: IconButton(
                                    icon: Icon(
                                        icon ? Icons.send_rounded : Icons.mic),
                                    onPressed: () {
                                      if (icon) {
                                        sendMessage();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          show ? emojiselect() : Container(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              onWillPop: () {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomPop() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(bottom: 45),
      height: 278,
      width: width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      Icons.insert_drive_file, Colors.indigo, "Document"),
                  SizedBox(
                    width: width * 0.1,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                  SizedBox(
                    width: width * 0.1,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio"),
                  SizedBox(
                    width: width * 0.1,
                  ),
                  iconCreation(Icons.location_pin, Colors.teal, "Location"),
                  SizedBox(
                    width: width * 0.1,
                  ),
                  iconCreation(Icons.person, Colors.blue, "Contact"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icon,
              color: Colors.white,
              size: 29,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget emojiselect() {
    return EmojiPicker(
        rows: 4,
        columns: 7,
        onEmojiSelected: (emoji, category) {
          _controller.text += emoji.emoji;
        });
  }

  void sendMessage() {
    widget.socket.emit("message", {
      "message": _controller.text,
      "from": prefs.getString('fullNumber'),
      "to": widget.chatmodel.name
    });
    _controller.text = '';
  }
}
