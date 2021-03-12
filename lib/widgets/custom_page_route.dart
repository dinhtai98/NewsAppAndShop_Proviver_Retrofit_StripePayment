import 'package:flutter/material.dart';

class BouncyPageRoute extends PageRouteBuilder {
  final Widget widget;

  BouncyPageRoute({this.widget})
      : super(
          transitionDuration: Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation = Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.bounceInOut,
              ),
            );
            return ScaleTransition(
                alignment: Alignment.center, scale: animation, child: child);
          },
          pageBuilder: (context, animation, secondaryAnimation) => widget,
        );
}
