// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:whatsapp/Screens/InitialSceens/phone_number.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.07,
              ),
              Text(
                "Welcome to Whatsapp",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: width * 0.07,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Image.asset(
                "images/bg.png",
                color: Theme.of(context).colorScheme.secondary,
                height: width * 0.85,
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.04,
                      ),
                      children: [
                        TextSpan(
                          text: "Agree and Continue to accept the ",
                        ),
                        TextSpan(
                          text:
                              "WhatsApp Clone's Terms of Service and Privacy Policy",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PhonePage()));
                },
                child: Container(
                  width: width * 0.95,
                  height: height * 0.06,
                  child: Card(
                    elevation: 4,
                    color: Theme.of(context).colorScheme.secondary,
                    child: Center(
                      child: Text(
                        "Agree and Continue",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.045,
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
    );
  }
}
