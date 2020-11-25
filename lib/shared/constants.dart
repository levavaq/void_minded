import 'package:flutter/material.dart';

const mainColor = Color(0xFF002424);

const textInputDecoration = InputDecoration(
  hintText: "example@gmail.com",
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black87, width: 2.0)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2.0)),
);
