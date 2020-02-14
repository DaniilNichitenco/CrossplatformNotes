import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:notes_app/Styles/Styles.dart';
import 'package:notes_app/UI_Elements/AppBarIcon.dart';
import 'package:notes_app/Animations/Scrolling.dart';

class NotePage extends StatefulWidget {
  NotePage(this.title, this.content);

  final String title;
  final Widget content;

  @override
  _NotePageState createState() => _NotePageState(title, content);
}

class _NotePageState extends State<NotePage> {
  _NotePageState([
    this.noteTitle,
    this.content = const TextField(
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Write here",
          hintStyle: TextStyle(fontStyle: FontStyle.italic)),
    ),
  ]);
  final String noteTitle;
  final Widget content;


  @override
  Widget build(BuildContext context) {

    Widget noteArea = new Container(
        child: ScrollConfiguration(behavior: ListScrollingWithoutIndicating(), child: ListView(
          children: ListTile.divideTiles(context: context, tiles: [
            ListTile(
              title: Container(
                child: Text(
                  noteTitle,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
            ),
            ListTile(
              title: Align(
                alignment: Alignment.topLeft,
                child: content,
              ),
            ),
          ]).toList(),
        )));

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
        backgroundColor: Styles.colorTheme,
      ),
      body: noteArea,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Create note',
        child: Icon(Icons.add),
        backgroundColor: Styles.colorTheme,
      ),
    );
  }
}
