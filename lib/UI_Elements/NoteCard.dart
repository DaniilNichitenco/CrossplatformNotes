import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/Animations/SlideRightRoute.dart';
import 'package:notes_app/Pages/NotePage.dart';
import 'package:notes_app/Styles/Styles.dart';
import 'package:notes_app/UI_Elements/Note.dart';

class NoteCard extends StatelessWidget {

  NoteCard({this.note, this.delete});

  final cardColor = Colors.white;
  // Color.fromARGB(255, 227, 242, 253); //Styles.cardColor;
  final Note note;
  final Function delete;

  _deleteNote(BuildContext context) {

    Widget cancelButton = FlatButton(
      child: Text('Cancel'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget deleteButton = FlatButton(
      child: Text('Delete'),
      onPressed: () {
        delete();
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text('Delete the note?'),
      content: Text('Are you sure you want to delete this note?'),
      actions: <Widget>[
        cancelButton,
        deleteButton
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.35;

    return Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        /*boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5.0,
                offset: Offset(3, 3),
              )
            ]*/
      ),
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.01,
          bottom: MediaQuery.of(context).size.height * 0.01,
          left: MediaQuery.of(context).size.width * 0.015,
          right: MediaQuery.of(context).size.width * 0.024),
      child: FlatButton(
        onPressed: () {
          Navigator.push(
              context, SlideRightRoute(page: NotePage(note.title, note.text)));
        },
        color: cardColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.black38) //Контур
            ),
        child: Container(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 0),
          constraints: BoxConstraints(
              minHeight: 100, maxHeight: 150, minWidth: width, maxWidth: width),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      note.title,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _deleteNote(context);
                    },
                    child: Icon(Icons.delete_forever, color: Colors.black, size: 20.0),
                  )
                ],
              ),
              Container(
                child: Text(note.text),
                margin: EdgeInsets.only(top: 5),
              )
            ],
          ),
        ),
      ),
    );
  }
}
