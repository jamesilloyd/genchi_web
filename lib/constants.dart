
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


const kEditAccountTextFieldDecoration = InputDecoration(
  hintText: "",
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
