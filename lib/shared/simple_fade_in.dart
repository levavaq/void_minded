import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum _AniPropsX { opacity, translateX }
enum _AniPropsY { opacity, translateY }

class FadeInX extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeInX(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_AniPropsX>()
      ..add(_AniPropsX.opacity, 0.0.tweenTo(1.0))
      ..add(_AniPropsX.translateX, 130.0.tweenTo(0.0));

    return PlayAnimation<MultiTweenValues<_AniPropsX>>(
      delay: (300 * delay).round().milliseconds,
      duration: 500.milliseconds,
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(_AniPropsX.opacity),
        child: Transform.translate(
          offset: Offset(value.get(_AniPropsX.translateX), 0),
          child: child,
        ),
      ),
    );
  }
}

class TranslateY extends StatelessWidget {
  final double delay;
  final Widget child;

  TranslateY(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_AniPropsY>()
      ..add(_AniPropsY.opacity, 1.0.tweenTo(1.0))
      ..add(_AniPropsY.translateY, 130.0.tweenTo(0.0));

    return PlayAnimation<MultiTweenValues<_AniPropsY>>(
      delay: (300 * delay).round().milliseconds,
      duration: 500.milliseconds,
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(_AniPropsY.opacity),
        child: Transform.translate(
          offset: Offset(value.get(_AniPropsY.translateY), 0),
          child: child,
        ),
      ),
    );
  }
}

class WhitespaceSeparator extends StatelessWidget {
  const WhitespaceSeparator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
    );
  }
}
