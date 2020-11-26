import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:void_minded/models/custom_user.dart';
import 'package:void_minded/screens/authenticate/authenticate.dart';
import 'package:void_minded/screens/features/dictionnary/dictionnary.dart';
import 'package:void_minded/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);

    // Return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Dictionnary();
    }
  }
}
