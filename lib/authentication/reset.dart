import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';

import '../variables.dart';
import 'navigationauthscreen.dart';

class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  TextEditingController emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Center(
              child: ExcludeSemantics(
                child: Image.asset(
                  'images/logo.png',
                  height: 700,
                  width: 700,
                ),
                excluding: true,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.6,
              margin: EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ],
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Reset Password",
                    style: mystyle(20, Theme.of(context).buttonColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Semantics(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: TextFormField(
                        controller: emailcontroller,
                        style: mystyle(18, Theme.of(context).accentColor),
                        decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email),
                            hintStyle: mystyle(20, Theme.of(context).hintColor,
                                FontWeight.w700)),
                        validator: (_val) {
                          if (_val.isEmpty) {
                            return "Can't be Empty";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    enabled: true,
                    label: 'Please enter your email address.',
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(email: emailcontroller.text);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 45,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: GradientColors.blue,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Semantics(
                          child: Text(
                            "Send Reset Link",
                            style: mystyle(20, Colors.white),
                          ),
                          enabled: true,
                          label:
                              'Double tap and you will be getting a reset link on your registered email id.',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
