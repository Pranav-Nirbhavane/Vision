import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vision/screens/profilescreen.dart';
import 'package:vision/screens/videoconferencescreen.dart';
import 'package:vision/variables.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 0;
  List pageoptions = [VideoConferenceScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).buttonColor,
        selectedItemColor: Colors.white,
        selectedLabelStyle: mystyle(17, Theme.of(context).primaryColor),
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: mystyle(17, Colors.white),
        currentIndex: page,
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Semantics(
              child: Icon(
                Icons.video_call,
                size: 32,
              ),
              enabled: true,
              label: 'Double tap to navigate to video conference screen.',
            ),
            title: Text("Video Call"),
          ),
          BottomNavigationBarItem(
            icon: Semantics(
              child: Icon(
                Icons.person,
                size: 32,
              ),
              enabled: true,
              label: 'Double tap to navigate to profile screen.',
            ),
            title: Text("Profile"),
          )
        ],
      ),
      body: pageoptions[page],
    );
  }
}
