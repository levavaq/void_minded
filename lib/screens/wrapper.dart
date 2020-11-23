import 'package:flutter/material.dart';
import 'package:void_minded/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Return either Home or Authenticate widget
    return Home();
  }
}
