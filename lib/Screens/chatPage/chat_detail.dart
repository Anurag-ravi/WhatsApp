// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/Components/chatPage/our_message.dart';
import 'package:whatsapp/Components/chatPage/their_message.dart';
import 'package:whatsapp/Utilities/box.dart';
import 'package:whatsapp/Utilities/time.dart';
import 'package:whatsapp/models/chat.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:whatsapp/models/message.dart';
import 'package:flutter/services.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

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
  bool loading = true;
  FocusNode focusnode = FocusNode();
  TextEditingController _controller = TextEditingController();
  late SharedPreferences prefs;
  ScrollController _scrollController = new ScrollController();
  List<MessageModel> messages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    focusnode.addListener(() {
      if (focusnode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
    init();
    getChats();
    widget.socket.on('reply', (data) async {
      if (data['from'] == widget.chatmodel.number) {
        setState(() {
          messages.add(MessageModel(
              message: data['message'], own: false, epoch: data['time']));
          AssetsAudioPlayer player = AssetsAudioPlayer();
          player.open(
            Audio("assets/recieve.mp3"),
          );
        });
      }
    });
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
    await Hive.openBox<MessageModel>(widget.chatmodel.number);
  }

  Future<void> getChats() async {
    await openMessageModelBox(widget.chatmodel.number);
    final box = Hive.box<MessageModel>(widget.chatmodel.number);
    List<MessageModel> temp = box.values.toList();
    temp.sort((a, b) {
      return a.epoch.compareTo(b.epoch);
    });
    setState(() {
      messages = temp;
      loading = false;
    });
    await openChatModelBox();
    final boxx = Hive.box<ChatModel>('chats');
    ChatModel instance = boxx.get(widget.chatmodel.number) as ChatModel;
    if (instance != null) {
      ChatModel now = ChatModel(
          number: instance.number,
          name: instance.name,
          lastmessage: instance.lastmessage,
          status: instance.status,
          epoch: instance.epoch,
          online: instance.online,
          last: instance.last,
          seen: true,
          time: instance.time);
      await boxx.put(widget.chatmodel.number, now);
    }
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
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xffc0c0c0),
                        child: SvgPicture.asset(
                          "images/person.svg",
                          color: Colors.white,
                          width: 35,
                          height: 35,
                        ),
                        radius: 23,
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 6,
                            backgroundColor: widget.chatmodel.online
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.transparent,
                          ))
                    ],
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
                    widget.chatmodel.online
                        ? 'online'
                        : 'last seen today at 18:26',
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
              child: Column(
                children: [
                  Expanded(
                    // height: height - 145,
                    child: loading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            shrinkWrap: true,
                            reverse: true,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final MessageModel message =
                                  messages[messages.length - 1 - index];
                              var date = DateTime.fromMillisecondsSinceEpoch(
                                  message.epoch);
                              int min = date.minute;
                              String time = "${date.hour}:";
                              if (min < 10) {
                                time += "0${min}";
                              } else {
                                time += "${min}";
                              }
                              if (message.own) {
                                return OurMessage(
                                    message: message.message, time: time);
                              }
                              return TheirMessage(
                                  message: message.message, time: time);
                            }),
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
          if (_controller.text.isNotEmpty) {
            setState(() {
              icon = true;
            });
          } else {
            setState(() {
              icon = false;
            });
          }
        });
  }

  void sendMessage() async {
    widget.socket.emit("message", {
      "message": _controller.text,
      "from": prefs.getString('fullNumber'),
      "time": DateTime.now().millisecondsSinceEpoch,
      "to": widget.chatmodel.number
    });
    AssetsAudioPlayer player = AssetsAudioPlayer();
    player.open(
      Audio("assets/send.mp3"),
    );
    final box = Hive.box<MessageModel>(widget.chatmodel.number);
    var mesg = MessageModel(
        message: _controller.text,
        own: true,
        epoch: DateTime.now().millisecondsSinceEpoch);
    box.add(mesg);
    setState(() {
      messages.add(mesg);
      icon = false;
    });
    updateLastMessage(_controller.text, DateTime.now().millisecondsSinceEpoch);
    _controller.text = '';
  }

  void updateLastMessage(String mess, int timee) async {
    await openChatModelBox();
    final chatBox = Hive.box<ChatModel>('chats');
    ChatModel obj = (chatBox.get(widget.chatmodel.number)) as ChatModel;
    chatBox.put(
        widget.chatmodel.number,
        ChatModel(
            number: widget.chatmodel.number,
            name: widget.chatmodel.name,
            lastmessage: mess,
            status: widget.chatmodel.status,
            epoch: timee,
            seen: true,
            last: true,
            online: widget.chatmodel.online,
            time: timeFromEpoch(timee)));
  }
}
