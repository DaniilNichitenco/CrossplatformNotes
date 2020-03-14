import 'package:flutter/material.dart';
import 'package:notes_app/UI_Elements/NoteCard.dart';
import 'package:notes_app/UI_Elements/Note.dart';

class ListCard extends StatefulWidget{

  @override
  _ListCardState createState() => _ListCardState();
}

class _ListCardState extends State<ListCard>{

  List<Note> notes = [
    Note(title: 'My note1', text: 'Something'),
    Note(title: 'My note1', text: 'Something'),
    Note(title: 'My note1', text: 'Something'),
    Note(title: 'My note', ),
    Note(text: 'Something'),
    Note(),
  ];

  @override
  Widget build(BuildContext context) {

    Widget list = new Wrap(
      children:
      notes.map((note) => NoteCard(note)).toList(),
    );

    return list;
  }
}
