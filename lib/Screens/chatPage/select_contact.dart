// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/Components/chatPage/button_card.dart';
import 'package:whatsapp/Components/chatPage/new_contact_card.dart';
import 'package:whatsapp/Screens/chatPage/new_group.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp/data.dart';
import 'package:whatsapp/models/contactmodel.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key? key}) : super(key: key);

  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  List<ContactModel> contacts = [];
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcontacts();
  }

  Future<void> getcontacts() async {
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
                  number: phonestr,
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
              print(value);
            },
            elevation: 5.0,
          ),
        ],
      ),
      body: !loading
          ? ListView.builder(
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
                  // return Container();
                }
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
