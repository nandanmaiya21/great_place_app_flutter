import 'package:flutter/material.dart';

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({required WidgetBuilder builder, RouteSettings? settings})
      : super(builder: builder, settings: settings);

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => Duration(seconds: 3);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.name == '/') {
      return child;
    }
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
          .animate(animation),
      child: child,
    );
  }
}

class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    // TODO: implement buildTransitions
    if (route.settings.name == '/') {
      return child;
    }
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
          .animate(animation),
      child: child,
    );
  }
}
