// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:convert';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/Components/chatPage/button_card.dart';
import 'package:whatsapp/Components/chatPage/new_contact_card.dart';
import 'package:whatsapp/Screens/chatPage/chat_detail.dart';
import 'package:whatsapp/Screens/chatPage/new_group.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp/Utilities/time.dart';
import 'package:whatsapp/data.dart';
import 'package:whatsapp/models/chat.dart';
import 'package:whatsapp/models/contactmodel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SelectContact extends StatefulWidget {
  const SelectContact({Key? key, required this.socket}) : super(key: key);
  final IO.Socket socket;

  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  List<ContactModel> contacts = [];
  bool loading = true;
  late Box<ContactModel> contactBox;
  late Box<ChatModel> chatBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContacts();
  }

  void getContacts() async {
    final box = Hive.box<ContactModel>('contacts');
    List<ContactModel> temp = box.values.toList();
    temp.sort((a, b) {
      return a.name
          .toString()
          .toLowerCase()
          .compareTo(b.name.toString().toLowerCase());
    });
    setState(() {
      contacts = temp;
      loading = false;
      contactBox = box;
    });
    final box1 = Hive.box<ChatModel>('chats');
    setState(() {
      chatBox = box1;
    });
  }

  Future<void> refreshcontacts() async {
    setState(() {
      loading = true;
    });
    List<Contact> _contacts = await ContactsService.getContacts();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse("${url}users/all"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    var list = [];
    if (response.statusCode == 200) {
      list = await json
          .decode(response.body)
          .map((data) => ContactModel.fromJson(data))
          .toList();
    }
    List<ContactModel> _contacts2 = [];
    List<String> numbers = [];
    list.forEach((listitem) {
      _contacts.forEach((contact) {
        if (contact.phones != null) {
          contact.phones!.forEach((element) {
            var phonestr = element.value.toString();
            if (listitem.number.contains(flattenphone(phonestr))) {
              var ele = ContactModel(
                  number: listitem.number,
                  name: contact.displayName.toString(),
                  status: listitem.status);
              if (numbers.contains(listitem.number) ||
                  prefs.getString('fullNumber') == listitem.number) {
              } else {
                _contacts2.add(ele);
                numbers.add(listitem.number);
              }
            }
          });
        }
      });
    });
    _contacts2.forEach((contact) async {
      await contactBox.put(contact.number, contact);
    });
    _contacts2.sort((a, b) {
      return a.name
          .toString()
          .toLowerCase()
          .compareTo(b.name.toString().toLowerCase());
    });
    setState(() {
      contacts = _contacts2;
      loading = false;
    });
  }

  String flattenphone(String phonestr) {
    var phone = phonestr.replaceAll(RegExp(r'^(\+)|\D'), '');
    return phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Contact",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
            ),
            Text(
              "${contacts.length} contacts",
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
              if (value == "Refresh") {
                refreshcontacts();
              }
            },
            elevation: 5.0,
          ),
        ],
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : contacts.isEmpty
              ? RefreshIndicator(
                  onRefresh: refreshcontacts,
                  child: Center(
                    child: Text(
                        "No Contacts Available, please refresh or invite your friends to the app"),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: refreshcontacts,
                  child: ListView.builder(
                    itemCount: contacts.length + 2,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => NewGroup()));
                          },
                          child: ButtonCard(
                            icon: Icons.group,
                            name: "New group",
                          ),
                        );
                      } else if (index == 1) {
                        return ButtonCard(
                          icon: Icons.person_add,
                          name: "New contact",
                        );
                      } else {
                        return InkWell(
                          child: NewContactCard(contact: contacts[index - 2]),
                          onTap: () {
                            ChatModel obj = (chatBox
                                .get(contacts[index - 2].number)) as ChatModel;
                            if (obj != null) {
                            } else {
                              DateTime now = DateTime.now();
                              chatBox.put(
                                  contacts[index - 2].number,
                                  ChatModel(
                                      number: contacts[index - 2].number,
                                      name: contacts[index - 2].name,
                                      lastmessage: '',
                                      status: contacts[index - 2].status,
                                      epoch: now.millisecondsSinceEpoch,
                                      seen: true,
                                      last: false,
                                      online: false,
                                      time: timeFromEpoch(
                                          now.millisecondsSinceEpoch)));
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatDetail(
                                          chatmodel: (chatBox.get(
                                                  contacts[index - 2].number))
                                              as ChatModel,
                                          socket: widget.socket,
                                        ))).then((value) => null);
                          },
                        );
                        // return Container();
                      }
                    },
                  ),
                ),
    );
  }
}
