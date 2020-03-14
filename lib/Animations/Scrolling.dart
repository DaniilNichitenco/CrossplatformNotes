import 'package:flutter/material.dart';

class ListScrollingWithoutIndicating extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
