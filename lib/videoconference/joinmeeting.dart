import 'dart:io';
import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vision/variables.dart';

class JoinMeeting extends StatefulWidget {
  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController roomcontroller = TextEditingController();
  bool isVideoMuted = true;
  bool isAudioMuted = true;
  String username = '';

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
    });
  }

  joinmeeting() async {
    try {
      Map<FeatureFlagEnum, bool> featureflags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      };
      if (Platform.isAndroid) {
        featureflags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        featureflags[FeatureFlagEnum.PIP_ENABLED] = false;
      }

      var options = JitsiMeetingOptions()
        ..room = roomcontroller.text
        ..userDisplayName =
            namecontroller.text == '' ? username : namecontroller.text
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;

      await JitsiMeet.joinMeeting(options);
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 15),
              Text(
                "Room Code",
                style: mystyle(20, Theme.of(context).buttonColor),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Semantics(
                  child: PinCodeTextField(
                    backgroundColor: Theme.of(context).backgroundColor,
                    textStyle: TextStyle(color: Theme.of(context).accentColor),
                    controller: roomcontroller,
                    appContext: context,
                    length: 6,
                    autoDisposeControllers: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(shape: PinCodeFieldShape.underline),
                    animationDuration: Duration(milliseconds: 300),
                    onChanged: (value) {},
                    onTap: () {
                      FlutterClipboard.paste().then((value) {});
                    },
                  ),
                  enabled: true,
                  label:
                      'You can paste the generated code present in your clipboard.',
                ),
              ),
              SizedBox(height: 20),
              Semantics(
                child: TextField(
                  controller: namecontroller,
                  style: mystyle(20, Theme.of(context).accentColor),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Name (Leave if you want your username )",
                      labelStyle: mystyle(15, Theme.of(context).accentColor)),
                ),
                enabled: true,
                label: 'You can change your name for the meeting.',
              ),
              SizedBox(height: 10),
              CheckboxListTile(
                value: isVideoMuted,
                onChanged: (value) {
                  setState(() {
                    isVideoMuted = value;
                  });
                },
                title: Text(
                  "Video Muted",
                  style: mystyle(18, Theme.of(context).accentColor),
                ),
              ),
              SizedBox(height: 16),
              CheckboxListTile(
                value: isAudioMuted,
                onChanged: (value) {
                  setState(() {
                    isAudioMuted = value;
                  });
                },
                title: Text(
                  "Audio Muted",
                  style: mystyle(18, Theme.of(context).accentColor),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "You can customise your settings in the meeting",
                style: mystyle(15),
                textAlign: TextAlign.center,
              ),
              Divider(
                height: 48,
                thickness: 2.0,
              ),
              InkWell(
                onTap: () => joinmeeting(),
                child: Semantics(
                  child: Container(
                    width: double.maxFinite,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Theme.of(context).buttonColor,
                    ),
                    child: Center(
                      child: Text(
                        "Join Meeting",
                        style: mystyle(20, Theme.of(context).cardColor),
                      ),
                    ),
                  ),
                  enabled: true,
                  label: 'Double tap to navigate to your meeting.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
