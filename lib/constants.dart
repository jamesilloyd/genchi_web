
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kGenchiOrange = 0xfff19300;
const kGenchiBlue = 0xff05004e;
const kGenchiCream = 0xfff9f8eb;
const kGenchiGreen = 0xff76b39d;
const kGenchiLightGreen = 0xffafcac0;

const kGenchiLightOrange = 0xffF7BE66;
const kGenchiBrown = 0xffD3CCAF;
const kGenchiLightBlue = 0xff534F8E;


Map<int, Color> orangeColor = {
  50: Color.fromRGBO(241, 147, 0, .1),
  100: Color.fromRGBO(241, 147, 0, .2),
  200: Color.fromRGBO(241, 147, 0, .3),
  300: Color.fromRGBO(241, 147, 0, .4),
  400: Color.fromRGBO(241, 147, 0, .5),
  500: Color.fromRGBO(241, 147, 0, .6),
  600: Color.fromRGBO(241, 147, 0, .7),
  700: Color.fromRGBO(241, 147, 0, .8),
  800: Color.fromRGBO(241, 147, 0, .9),
  900: Color.fromRGBO(241, 147, 0, 1),
};


const kRed = 0xffDA2222;
const kGreen = 0xff41820E;
const kPurple = 0xff5415BA;

TextStyle kTitleTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w500,
);

const kHeaderTextStyle = TextStyle(
  fontSize: 60,
);


const kBodyTextStyle = TextStyle(
  fontSize: 20,
);

const debugMode = true;

const kApplicationLinkNotWorking = SnackBar(
  backgroundColor: Color(kGenchiOrange),
  duration: Duration(seconds: 5),
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
  content: Text(
    'Sorry, it appears this link is not working. We will fix ASAP',
    style: TextStyle(
        color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
    textAlign: TextAlign.center,
  ),
);


const kEditAccountTextFieldDecoration = InputDecoration(
  hintText: "",
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  fillColor: Colors.white,
  filled: true,
  hintStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w300,
      fontFamily: 'FuturaPT'
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: .5),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);


const String kPlayStoreURL = 'https://play.google.com/store/apps/details?id=app.genchi.genchi';
const String kAppStoreURL = 'https://apps.apple.com/us/app/genchi/id1473696183';
