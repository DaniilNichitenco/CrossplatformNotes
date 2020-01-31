import 'package:flutter/material.dart';
import 'package:notes_app/UI_Elements/NoteCard.dart';

class ListCard extends StatefulWidget{

  @override
  _ListCardState createState() => _ListCardState();
}

class _ListCardState extends State<ListCard>{

  @override
  Widget build(BuildContext context) {

    Widget list = new Wrap(
      children: <Widget>[
        NoteCard(Colors.yellow),
        NoteCard(
            Colors.green,
            "Blablablav12",
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[Text("1234541safs\ndsfasdfasd\nfasf")],
            )
        ),
        NoteCard(Colors.red),
        NoteCard(Colors.blue),
        NoteCard(Colors.deepOrange),
        NoteCard(Colors.yellow),
        NoteCard(Colors.yellow),
        NoteCard(Colors.yellow),
        NoteCard(Colors.deepOrange),
        NoteCard(Colors.yellow),
        NoteCard(Colors.yellow),
      ],
    );

    return list;
  }
}
