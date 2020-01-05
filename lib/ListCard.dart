import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Note.dart';

class ListCard extends StatelessWidget {
  ListCard(this.cardColor,
      [this.cardContent = const Text("Note")]);

  final Color cardColor;
  final Text cardContent;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width * 0.35;

    return Container(
        padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
        child: FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> NotePage(cardContent)));
            },
            color: cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              //side: BorderSide(color: Colors.black) //Контур
            ),
            child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 0),
              constraints: BoxConstraints(
                  minHeight: 100, minWidth: width, maxWidth: width),
              child: Container(
                child: Column(
                  children: <Widget>[Center(
                    child: cardContent,
                  ),],
                ),
              ),
            )));
  }
}