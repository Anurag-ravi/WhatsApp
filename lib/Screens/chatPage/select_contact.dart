// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:whatsapp/Components/chatPage/button_card.dart';
import 'package:whatsapp/Components/chatPage/contact_card.dart';
import 'package:whatsapp/Components/chatPage/new_contact_card.dart';
import 'package:whatsapp/Screens/chatPage/new_group.dart';
import 'package:whatsapp/models/chat_Model.dart';
import 'package:contacts_service/contacts_service.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key? key}) : super(key: key);

  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  List<Contact> contacts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getcontacts();
  }

  Future<void> getcontacts() async {
    List<Contact> _contacts =
        (await ContactsService.getContacts(withThumbnails: false));
    setState(() {
      contacts = _contacts;
    });
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
                "268 contacts",
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
        body: ListView.builder(
          itemCount: contacts.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => NewGroup()));
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
              return NewContactCard(contact: contacts[index - 2]);
            }
          },
        ));
  }
}
