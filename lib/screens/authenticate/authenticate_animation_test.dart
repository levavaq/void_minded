import 'package:flutter/material.dart';
import 'package:void_minded/animations/loading.dart';
import 'package:void_minded/services/auth.dart';
import 'package:void_minded/shared/constants.dart';

class AuthenticateAnimationTest extends StatefulWidget {
  @override
  _AuthenticateAnimationTestState createState() =>
      _AuthenticateAnimationTestState();
}

class _AuthenticateAnimationTestState extends State<AuthenticateAnimationTest> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation sizeAnimation;
  Animation colorAnimation;

  @override
  void initState() {
    super.initState();
    controller =  AnimationController(vsync: this, duration: Duration(seconds: 2));
    colorAnimation = ColorTween(begin: Colors.blue, end: Colors.yellow).animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));
    sizeAnimation = Tween<double>(begin: 100.0, end: 200.0).animate(controller);
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation Demo"),
      ),
      body: Center(
        child: Container(
          height: sizeAnimation.value,
          width: sizeAnimation.value,
          color: colorAnimation.value,
        ),
      ),
    );
  }
}
