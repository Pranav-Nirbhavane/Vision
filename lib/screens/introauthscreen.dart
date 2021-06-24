import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:vision/authentication/navigationauthscreen.dart';
import 'package:vision/variables.dart';

class IntroAuthScreen extends StatefulWidget {
  @override
  _IntroAuthScreenState createState() => _IntroAuthScreenState();
}

class _IntroAuthScreenState extends State<IntroAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "VISION",
          body: "Where the limitations end!",
          image: Center(
            child: Semantics(
              child: Image.asset(
                'images/logo.png',
                height: 500,
                width: 700,
              ),
              enabled: false,
            ),
          ),
          decoration: PageDecoration(
            bodyTextStyle: mystyle(20, Theme.of(context).accentColor),
            titleTextStyle: mystyle(50, Theme.of(context).accentColor),
          ),
        ),
        PageViewModel(
          title: "Welcome",
          body: "Welcome to Vision, the best video conference app",
          image: Center(
            child: Semantics(
              child: Image.asset(
                'images/welcome.png',
                height: 500,
                width: 700,
              ),
              enabled: false,
            ),
          ),
          decoration: PageDecoration(
            bodyTextStyle: mystyle(20, Theme.of(context).accentColor),
            titleTextStyle: mystyle(20, Theme.of(context).accentColor),
          ),
        ),
        PageViewModel(
          title: "Join or start meetings",
          body:
              "Easy to use interface for visually challenged users too, join or start meetings instantly",
          image: Center(
            child: Semantics(
              child: Image.asset(
                'images/conference.png',
                height: 500,
                width: 700,
              ),
              enabled: false,
            ),
          ),
          decoration: PageDecoration(
            bodyTextStyle: mystyle(20, Theme.of(context).accentColor),
            titleTextStyle: mystyle(20, Theme.of(context).accentColor),
          ),
        ),
        PageViewModel(
          title: "Security",
          body:
              "Your security is important for us.\nOur servers are secure and reliable",
          image: Center(
            child: Semantics(
              child: Image.asset(
                'images/security.png',
                height: 500,
                width: 500,
              ),
              enabled: false,
            ),
          ),
          decoration: PageDecoration(
            bodyTextStyle: mystyle(20, Theme.of(context).accentColor),
            titleTextStyle: mystyle(20, Theme.of(context).accentColor),
          ),
        ),
      ],
      onDone: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NavigateAuthScreen()));
      },
      onSkip: () {},
      showSkipButton: false,

      /// Make it false
      skip: Semantics(
        child: const Icon(Icons.skip_next, size: 45),
        enabled: false,
      ),
      next: Semantics(
        child: const Icon(Icons.arrow_forward_ios),
        enabled: true,
        label: 'Next',
      ),
      done: Semantics(
        child: Text(
          "Done",
          style: mystyle(20, Theme.of(context).buttonColor),
        ),
        enabled: true,
        label: 'Double tap to go on Login page.',
      ),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: Theme.of(context).accentColor,
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }
}
