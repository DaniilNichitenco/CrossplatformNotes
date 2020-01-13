import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  NotePage(this.title);

  final String title;

  @override
  _NotePageState createState() => _NotePageState(title);
}

class _NotePageState extends State<NotePage> {
  _NotePageState(this.noteTitle);
  final String noteTitle;

  void createNote() {
    setState(() {});
  }

  Color bgcolor = Color.fromARGB(255, 33, 39, 97);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(noteTitle),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_alert),
            tooltip: "Show alerts",
            iconSize: 22,
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
              tooltip: "Settings"),
        ],
        backgroundColor: bgcolor,
      ),
      body: Column(
        children: <Widget>[
          Text(noteTitle,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        tooltip: 'Create note',
        child: Icon(Icons.add),
        backgroundColor: bgcolor,
      ),
    );
  }
}