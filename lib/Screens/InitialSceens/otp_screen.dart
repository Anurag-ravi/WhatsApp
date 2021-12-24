// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp/data.dart';
import 'package:whatsapp/pages/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen(
      {Key? key,
      required this.countryCode,
      required this.Number,
      required this.hash})
      : super(key: key);

  final String countryCode;
  final String Number;
  final String hash;

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool otpverifysent = false;
  bool verified = false;

  final String verifyUri = url + "users/verifyotp";
  final String loginUri = url + "users/login";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              "Verify ${widget.countryCode} ${widget.Number}",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: width * 0.045,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  )),
            ],
          ),
          body: Container(
            width: width,
            height: height,
            child: Column(
              children: [
                SizedBox(height: 10),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.04,
                      ),
                      children: [
                        TextSpan(
                          text: "We have sent an SMS to ",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "${widget.countryCode} ${widget.Number}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Wrong number?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.04),
                OTPTextField(
                  length: 6,
                  keyboardType: TextInputType.number,
                  width: width * 0.95,
                  fieldWidth: width * 0.1,
                  style: TextStyle(fontSize: 17),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.underline,
                  onCompleted: (pin) async {
                    await verifyOTP(pin.toString());
                  },
                ),
                SizedBox(height: height * 0.05),
                Text(
                  "Enter the code",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: width * 0.035,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.04,
                    ),
                    Icon(
                      Icons.message,
                      color: Theme.of(context).colorScheme.secondary,
                      size: width * 0.07,
                    ),
                    SizedBox(
                      width: width * 0.04,
                    ),
                    Text(
                      "Resend SMS",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.04,
                    ),
                    Icon(
                      Icons.call,
                      color: Theme.of(context).colorScheme.secondary,
                      size: width * 0.07,
                    ),
                    SizedBox(
                      width: width * 0.04,
                    ),
                    Divider(
                      thickness: 1,
                      height: 1,
                    ),
                    Text(
                      "Call me",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        otpverifysent
            ? Container(
                height: height,
                width: width,
                color: otpverifysent ? Colors.black38 : Colors.transparent,
              )
            : Container(),
        otpverifysent
            ? Center(
                child: otpverifysent
                    ? CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.secondary,
                      )
                    : null,
              )
            : Container(),
      ],
    );
  }

  Future<void> verifyOTP(String otp) async {
    // first make page unresponsive
    setState(() {
      otpverifysent = true;
    });
    // send post request to verify otp
    final response = await http.post(
      Uri.parse(verifyUri),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "phone": widget.countryCode + widget.Number,
        "otp": otp,
        "hash": widget.hash
      }),
    );
    // check the response to see whether otp verified or not
    if (response.statusCode == 200) {
      var data = await jsonDecode(response.body);
      if (data['status'] == 200) {
        // otp verified
        // got to main page
        var snackBar = SnackBar(
          content: Text(data['message']),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        await loginUser();
        setState(() {
          verified = true;
          otpverifysent = false;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(
              title: "WhatsApp Clone",
              prefs: prefs,
            ),
          ),
        );
      } else {
        // otp not verified
        setState(() {
          otpverifysent = false;
        });
        var snackBar = SnackBar(
          content: Text(data['message']),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      setState(() {
        otpverifysent = false;
      });
      const snackBar = SnackBar(
        content: Text('Some error occured, please try after sometime'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    setState(() {
      otpverifysent = false;
    });
  }

  Future<void> loginUser() async {
    final response = await http.post(
      Uri.parse(loginUri),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(
          <String, String>{"fullNumber": widget.countryCode + widget.Number}),
    );
    if (response.statusCode == 200) {
      var data = await jsonDecode(response.body);
      if (data['status'] != 400) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var user = data['message'];
        prefs.setString("fullNumber", user['_id'].toString());
        prefs.setString("name", user['name'].toString());
        prefs.setString("status", user['status'].toString());
      }
    } else {
      print(response.statusCode);
    }
  }
}
