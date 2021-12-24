// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:whatsapp/Screens/InitialSceens/otp_screen.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp/data.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({Key? key}) : super(key: key);

  @override
  _PhonePageState createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  String completeNumber = "";
  String countryCode = "";
  String Number = "";
  String hash = "";
  bool otpsent = false;
  final String uri = url + "users/sendotp";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Container(),
            title: Text(
              "Enter your Phone Number",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: width * 0.045,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
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
                },
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
                elevation: 5.0,
              ),
            ],
          ),
          body: Container(
            height: height,
            width: width,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "WhatsApp will send an SMS to verify your phone number",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: width * 0.03,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: IntlPhoneField(
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          initialCountryCode: 'IN',
                          onChanged: (phone) {
                            setState(() {
                              completeNumber = phone.completeNumber;
                              countryCode = phone.countryCode;
                              Number = phone.number;
                            }); // only phone number
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: width * 0.2),
                    child: InkWell(
                      onTap: () {
                        if (Number.length < 10) {
                          showMy2Dialouge();
                        } else {
                          showMyDialouge();
                        }
                      },
                      child: Container(
                        width: width * 0.4,
                        height: height * 0.06,
                        child: Card(
                          elevation: 4,
                          color: Theme.of(context).colorScheme.secondary,
                          child: Center(
                            child: Text(
                              "Next",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.045,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        otpsent
            ? Container(
                height: height,
                width: width,
                color: otpsent ? Colors.black38 : Colors.transparent,
              )
            : Container(),
        otpsent
            ? Center(
                child: otpsent
                    ? CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.secondary,
                      )
                    : null,
              )
            : Container(),
      ],
    );
  }

  Future<void> sendOTP() async {
    final response = await http.post(
      Uri.parse(uri),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{"phone": completeNumber}),
    );
    if (response.statusCode == 200) {
      var data = await jsonDecode(response.body);
      setState(() {
        hash = data['hash'];
      });
    } else {
      print(response.statusCode);
    }
  }

  Future<void> showMyDialouge() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "We will be verifying your phone number",
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    countryCode + " " + Number,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Is this ok, or would you like to edit the number",
                    style: TextStyle(fontSize: 13.5),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Edit"),
              ),
              TextButton(
                onPressed: () async {
                  setState(() {
                    otpsent = true;
                  });
                  await sendOTP();
                  setState(() {
                    otpsent = false;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OTPScreen(
                                Number: Number,
                                countryCode: countryCode,
                                hash: hash,
                              )));
                },
                child: Text("Ok"),
              ),
            ],
          );
        });
  }

  Future<void> showMy2Dialouge() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Please Enter a valid number",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Ok"),
              ),
            ],
          );
        });
  }
}
