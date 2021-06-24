import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:vision/authentication/navigationauthscreen.dart';
import 'package:vision/variables.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = '';
  bool dataisthere = false;

  TextEditingController usernamecontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
  }

  getuserdata() async {
    DocumentSnapshot userdoc =
        await usercollection.doc(FirebaseAuth.instance.currentUser.uid).get();
    setState(() {
      username = userdoc.data()['username'];
      dataisthere = true;
    });
  }

  editprofile() async {
    usercollection
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({'username': usernamecontroller.text});
    setState(() {
      username = usernamecontroller.text;
    });
    Navigator.pop(context);
  }

  openeditprofiledialogue() async {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 200,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: TextFormField(
                      controller: usernamecontroller,
                      style: mystyle(18, Theme.of(context).accentColor),
                      decoration: InputDecoration(
                        labelText: "Update username",
                        labelStyle: mystyle(16, Theme.of(context).accentColor),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      validator: (_val) {
                        if (_val.isEmpty) {
                          return "Can't be Empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () => editprofile(),
                    child: Semantics(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 40,
                        decoration: BoxDecoration(
                            gradient:
                                LinearGradient(colors: GradientColors.teal)),
                        child: Center(
                          child: Text(
                            "Update Now!",
                            style: mystyle(17, Colors.white),
                          ),
                        ),
                      ),
                      enabled: true,
                      label: 'Double tap to update your username.',
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: dataisthere == false
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  ClipPath(
                    clipper: OvalBottomBorderClipper(),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 2.5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xFF00ACC1), Color(0xFF00897B)]),
                      ),
                    ),
                  ),
                  ExcludeSemantics(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 2 - 64,
                          top: MediaQuery.of(context).size.height / 3.1),
                      child: CircleAvatar(
                        radius: 64,
                        backgroundImage: AssetImage('images/user_pic.png'),
                      ),
                    ),
                    excluding: true,
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 300,
                        ),
                        Text(
                          username,
                          style: mystyle(40, Theme.of(context).accentColor),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () => openeditprofiledialogue(),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 40,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: GradientColors.teal)),
                            child: Center(
                              child: Text(
                                "Edit Profile",
                                style:
                                    mystyle(17, Theme.of(context).accentColor),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NavigateAuthScreen()));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 40,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: GradientColors.orange)),
                            child: Center(
                              child: Text(
                                "Sign Out",
                                style:
                                    mystyle(17, Theme.of(context).accentColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
  }
}
