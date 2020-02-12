import 'package:flutter/material.dart';

class logListScrolling extends ScrollBehavior{

  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection
      ){
    return child;
  }
}