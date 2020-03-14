import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/Animations/SlideRightRoute.dart';
import 'package:notes_app/Pages/NotePage.dart';
import 'package:notes_app/Styles/Styles.dart';
import 'package:notes_app/UI_Elements/Note.dart';

class NoteCard extends StatelessWidget {

  final cardColor = Styles.cardColor;
  final Note note;
  NoteCard(this.note);


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.35;

    return Container(
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5.0,
                offset: Offset(8, 8),
              )
            ]),
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.01,
            bottom: MediaQuery.of(context).size.height * 0.01,
            left: MediaQuery.of(context).size.width * 0.015,
            right: MediaQuery.of(context).size.width * 0.024),
        child: FlatButton(
            onPressed: () {
              Navigator.push(context,
                  SlideRightRoute(page: NotePage(note.title, note.text)));
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    note.title,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    child: note.text,
                    margin: EdgeInsets.only(top: 5),
                  )
                ],
              ),
            )));
  }
}
