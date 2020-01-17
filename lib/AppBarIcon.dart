import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarIcon extends StatefulWidget {
  final bool isChecked;
  final String checkedText;
  final String uncheckedText;
  final IconData checkedIcon;
  final IconData uncheckedIcon;

  static _AppBarIconState pageState;

  AppBarIcon(
      {this.isChecked = false,
      this.uncheckedText,
      this.checkedText,
      this.checkedIcon,
      this.uncheckedIcon}) {

        pageState = new _AppBarIconState(isChecked);
      }
  @override
  _AppBarIconState createState() => pageState;
}

class _AppBarIconState extends State<AppBarIcon> {
  bool isChecked;

  _AppBarIconState([this.isChecked]);

  void action() {
    setState(() {
      isChecked = !isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: (isChecked ? Icon(widget.checkedIcon) : Icon(widget.uncheckedIcon)),
      onPressed: () {
        action();
      },
      tooltip: (isChecked ? widget.checkedText : widget.uncheckedText),
    );
  }
}
