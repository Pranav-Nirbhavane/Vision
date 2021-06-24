import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:uuid/uuid.dart';
import 'package:vision/variables.dart';

class CreateMeeting extends StatefulWidget {
  @override
  _CreateMeetingState createState() => _CreateMeetingState();
}

class _CreateMeetingState extends State<CreateMeeting> {
  String code = '';
  TextEditingController meetpasswordcontroller = TextEditingController();

  createcode() {
    setState(() {
      code = Uuid().v1().substring(0, 6);
    });
  }

  Future<void> share(String meetingCode, String password) async {
    await FlutterShare.share(
      title: 'Share Details',
      text:
          'Vision - A Video Conferencing Application\nDetails for joining the meeting:-',
      chooserTitle: 'Where Do You Want To Share',
      linkUrl: 'Meeting Code: $meetingCode\nPassword: $password',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Create a code and share it with the Participants",
                style: mystyle(20),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Code:   ",
                  style: mystyle(30),
                ),
                Text(
                  code,
                  style: mystyle(
                      30, Theme.of(context).accentColor, FontWeight.w700),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () => createcode(),
                  child: Semantics(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: GradientColors.blue),
                      ),
                      child: Center(
                        child: Text(
                          "Create Code",
                          style: mystyle(20, Colors.white),
                        ),
                      ),
                    ),
                    enabled: true,
                    label: 'Create code to start a new meeting.',
                  ),
                ),
                InkWell(
                  onTap: () {
                    FlutterClipboard.copy(code)
                        .then((value) => print('copied'));
                  },
                  child: Semantics(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: GradientColors.green),
                      ),
                      child: Center(
                        child: Text(
                          "Copy Code",
                          style: mystyle(20, Colors.white),
                        ),
                      ),
                    ),
                    enabled: true,
                    label: 'Double tap to copy the code on clipboard.',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Set password for the meeting",
                style: mystyle(20),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Semantics(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.7,
                decoration: BoxDecoration(
                    borderRadius: new BorderRadius.circular(10.0),
                    border: Border.all(color: Theme.of(context).accentColor)),
                child: TextFormField(
                  controller: meetpasswordcontroller,
                  keyboardType: TextInputType.number,
                  style: mystyle(18, Theme.of(context).accentColor),
                  decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock),
                      hintStyle: mystyle(
                          20, Theme.of(context).hintColor, FontWeight.w700)),
                  validator: (_val) {
                    if (_val.isEmpty) {
                      return "None";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              enabled: true,
              label:
                  'Double tap to set password or enable lobby mode for securing the meet.',
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                share(code, meetpasswordcontroller.text);
              },
              child: Semantics(
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: 40,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: GradientColors.orange)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Share",
                        style: mystyle(17, Theme.of(context).accentColor),
                      ),
                    ],
                  ),
                ),
                enabled: true,
                label: 'Share the meeting details with other participants.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
