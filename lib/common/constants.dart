import 'package:flutter/material.dart';

const kMainColor = Color(0xff2E4FFA);

const kButtonColor = Color(0xff2E4FFA);

const kTextInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  fillColor: Colors.white,
  filled: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kMainColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kMainColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kFalseColor = Colors.black54;
const kFalseDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: kFalseColor, width: 1.0),
    right: BorderSide(color: kFalseColor, width: 8.0),
    bottom: BorderSide(color: kFalseColor, width: 2.0),
    left: BorderSide(color: kFalseColor, width: 1.0),
  ),
);

const kTrueColor = kMainColor;
const kTrueDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: kTrueColor, width: 1.0),
    right: BorderSide(color: kTrueColor, width: 1.0),
    bottom: BorderSide(color: kTrueColor, width: 2.0),
    left: BorderSide(color: kTrueColor, width: 8.0),
  ),
);
