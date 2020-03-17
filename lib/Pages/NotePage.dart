import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:notes_app/Styles/Styles.dart';
import 'package:notes_app/UI_Elements/AppBarIcon.dart';
import 'package:notes_app/Animations/Scrolling.dart';
import 'package:notes_app/UI_Elements/popup_menu.dart';

class NotePage extends StatefulWidget {
  NotePage(this.title, this.text);

  final String title;
  final String text;

  @override
  _NotePageState createState() => _NotePageState(title, text);
}

class _NotePageState extends State<NotePage> {
  final String noteTitle;
  static String noteText;

  _NotePageState([this.noteTitle, text,]) {
    noteText = text;
  }

  choiceAction(choice){
    switch(choice){
      case PopupMenu.Rename:
        {
          print(choice);
          break;
        }
      case PopupMenu.Delete:
        {
          print(choice);
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {

    Widget content = TextFormField(
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Write here...',
          hintStyle: TextStyle(fontStyle: FontStyle.italic)),
    );

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

    Widget popupMenu() => PopupMenuButton<String>(
      onSelected: choiceAction,
      itemBuilder: (context) {
        return PopupMenu.notePageList.map((String choice){
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
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
