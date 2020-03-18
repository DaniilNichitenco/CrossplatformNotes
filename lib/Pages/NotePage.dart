import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:notes_app/UI_Elements/Note.dart';
import 'package:notes_app/Styles/Styles.dart';
import 'package:notes_app/UI_Elements/AppBarIcon.dart';
import 'package:notes_app/Animations/Scrolling.dart';
import 'package:notes_app/UI_Elements/popup_menu.dart';

class NotePage extends StatefulWidget {
  NotePage(this.note, this.delete);

  final Note note;
  final Function delete;

  @override
  _NotePageState createState() => _NotePageState(note, delete);
}

class _NotePageState extends State<NotePage> {

  TextEditingController _controller = TextEditingController();

  final Note note;
  final Function delete;

  _NotePageState([this.note, this.delete]);

  void initState() {
    _controller = TextEditingController(text: note.text);
    _controller.addListener(() {
      note.text = _controller.text;
    });
    super.initState();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text('Delete ${note.title}?'),
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

  _renameNote(BuildContext context) {

    final _formKey = GlobalKey<FormState>();
    String _newTitle;

    Widget renameField = TextFormField(
      initialValue: note.title,
      textInputAction: TextInputAction.go,
      keyboardType: TextInputType.text,
      maxLines: 1,
      maxLength: 10,
      validator: (value){
        if(value.isEmpty){
          return 'Field cannot be empty';
        }
        _newTitle = value;
        return null;
      },
      onFieldSubmitted: (v) {
        if(_formKey.currentState.validate())
          {
            setState(() {
              note.title = _newTitle;
            });
            Navigator.of(context).pop();
          }
      },
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide: new BorderSide(color: Colors.grey)),
          focusedBorder: UnderlineInputBorder(
              borderSide: new BorderSide(color: Colors.black)),
          hintText: 'Rename...',
          hintStyle: TextStyle(fontStyle: FontStyle.italic)),
    );

    Widget cancelButton = FlatButton(
      child: Text('Cancel'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget renameButton = FlatButton(
      child: Text('Rename'),
      onPressed: () {
        if(_formKey.currentState.validate())
          {
            setState(() {
              note.title = _newTitle;
            });
            Navigator.of(context).pop();
          }
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text('Rename the ${note.title}?'),
      content: Form(
        key: _formKey,
        child: renameField,
      ),
      actions: <Widget>[
        cancelButton,
        renameButton
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        }
    );
  }

  choiceAction(choice){
    switch(choice){
      case PopupMenu.Rename:
        {
          _renameNote(context);
          print(choice);
          break;
        }
      case PopupMenu.Delete:
        {
          _deleteNote(context);
          print(choice);
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {

    Widget content = TextFormField(
      controller: _controller,
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
                  note.title,
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
        title: Text(note.title),
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
