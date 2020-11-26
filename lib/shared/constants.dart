import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const mainColor = Color(0xFF002424);

const textStyle = TextStyle(fontSize: 15.0);

const textInputDecoration = InputDecoration(
  hintStyle: TextStyle(color: Colors.white54),
  labelStyle: TextStyle(color: Colors.white54),
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white70, width: 1.0)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 1.5)),
);

const raisedButtonShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.zero,
);
