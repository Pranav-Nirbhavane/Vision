import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';

import '../variables.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

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
                    "Create your account",
                    style: mystyle(20, Theme.of(context).buttonColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Semantics(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: TextField(
                        style: mystyle(18, Theme.of(context).accentColor),
                        controller: usernamecontroller,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                            hintText: "Username",
                            prefixIcon: Icon(Icons.person),
                            hintStyle: mystyle(
                                20,
                                Theme.of(context).accentColor,
                                FontWeight.w700)),
                      ),
                    ),
                    enabled: true,
                    label: 'Please enter your username for account.',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Semantics(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: TextField(
                        style: mystyle(18, Theme.of(context).accentColor),
                        controller: emailcontroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email),
                            hintStyle: mystyle(
                                20,
                                Theme.of(context).accentColor,
                                FontWeight.w700)),
                      ),
                    ),
                    enabled: true,
                    label: 'Please enter your email address.',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Semantics(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: TextFormField(
                        style: mystyle(18, Theme.of(context).accentColor),
                        controller: passwordcontroller,
                        textCapitalization: TextCapitalization.none,
                        decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(Icons.lock),
                            hintStyle: mystyle(
                                20,
                                Theme.of(context).accentColor,
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
                    label: 'Please enter your password.',
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      try {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailcontroller.text,
                                password: passwordcontroller.text)
                            .then((signeduser) {
                          usercollection.doc(signeduser.user.uid).set({
                            'username': usernamecontroller.text,
                            'email': emailcontroller.text,
                            'password': passwordcontroller.text,
                            'uid': signeduser.user.uid,
                          });
                        });
                        Navigator.pop(context);
                      } catch (e) {
                        print(e);
                        var snackbar = SnackBar(
                          content: Text(
                            e.toString(),
                            style: mystyle(20),
                          ),
                        );
                        Scaffold.of(context).showSnackBar(snackbar);
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 45,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: GradientColors.green,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Semantics(
                          child: Text(
                            "SIGN UP",
                            style: mystyle(25, Colors.white),
                          ),
                          enabled: true,
                          label:
                              'Double tap to create account and now you are back to authentication page where you can sign in.',
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
