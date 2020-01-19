import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'AppBarIcon.dart';

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

  @override
  Widget build(BuildContext context) {

    Widget popupMenu() => PopupMenuButton(
      itemBuilder: (context) {
        var list = List<PopupMenuEntry<Object>>();
        list.add(
          PopupMenuItem(
            child: Text("Settings"),
            value: 1,
          ),
        );
        list.add(
          PopupMenuItem(
            child: Text("Profile"),
            value: 2,
          ),
        );
        list.add(
          PopupMenuItem(
            child: Text("Languages"),
            value: 3,
          ),
        );
        return list;
      },
      elevation: 5,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(noteTitle),
        actions: <Widget>[
          AppBarIcon(
            isChecked: false,
            uncheckedText: "Add to favorites",
            checkedText: "Remove from favorites",
            checkedIcon: Icons.star,
            uncheckedIcon: Icons.star_border,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_alert),
            tooltip: "Show alerts",
            iconSize: 22,
          ),
          popupMenu(),
        ],
        backgroundColor: colorTheme,
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
        backgroundColor: colorTheme,
      ),
    );
  }
}