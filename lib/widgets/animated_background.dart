import 'package:flutter/material.dart';

class AnimatedBackground extends AnimatedWidget {
  final Animation<double> animation;
  final Widget child;

  AnimatedBackground({Key? key, required this.animation, required this.child})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> anim = listenable as Animation<double>;
    return Stack(
      children: <Widget>[
        PositionedTransition(
          rect: RelativeRectTween(
            begin: RelativeRect.fromLTRB(50, 50, 50, 300),
            end: RelativeRect.fromLTRB(50, 100, 50, 50),
          ).animate(anim),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pinkAccent, Colors.orangeAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
