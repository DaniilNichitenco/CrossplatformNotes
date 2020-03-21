import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/Styles/Styles.dart';
import 'package:notes_app/Animations/Scrolling.dart';
import 'package:notes_app/UI_Elements/popup_menu.dart';
import 'package:notes_app/bloc/Note_bloc.dart';
import 'package:notes_app/db/database_provider.dart';
import 'package:notes_app/events/Update_note.dart';
import 'package:notes_app/model/Note.dart';

class NotePage extends StatefulWidget {
  NotePage({this.note, this.delete, this.index});

  final Note note;
  final Function delete;
  final int index;

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {

  TextEditingController _controller = TextEditingController();

  String _title;
  String _content;
  bool _isFavorite = false;

  void initState() {
    print('init');

    _title = widget.note.name;
    _content = widget.note.content;
    _isFavorite = widget.note.isFavorite;

    _controller = TextEditingController(text: _content);

    _controller.addListener(() {
      _content = _controller.text;

      _save();
    }

    );
    super.initState();
  }

  @override
  void dispose() {

    _save();

    _controller.dispose();
    super.dispose();
  }

  void _save() {

    setState(() {

      Note note = Note(
          name: _title,
          content: _content,
          isFavorite: _isFavorite,
          id: widget.note.id
      );

      DatabaseProvider.db.update(note).then(
            (storedNote) => BlocProvider.of<NoteBloc>(context).add(
          UpdateNote(widget.index, note),
        ),
      );

    });

  }

  void _addFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;

     _save();

    });
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
        widget.delete();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text('Delete ${_title}?'),
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
      initialValue: _title,
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
            _title = _newTitle;

            _save();

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
            _title = _newTitle;

            _save();

          });
          Navigator.of(context).pop();
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text('Rename "${_title}"?'),
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

    print(widget.note.name);

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
                  _title,
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
        title: Text(_title),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _addFavorite();
            },
            icon: _isFavorite ? Icon(Icons.star) : Icon(Icons.star_border),
            tooltip: _isFavorite ? "Add to favorites" : "Remove frome favorits",
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
