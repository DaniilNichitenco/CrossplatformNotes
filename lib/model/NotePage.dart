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
import 'package:zefyr/zefyr.dart';

class NotePage extends StatefulWidget {
  NotePage({this.note, this.delete, this.index});

  final Note note;
  final Function delete;
  final int index;

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> with WidgetsBindingObserver {

  ZefyrController _controller;
  FocusNode _focusNode;

  String _title;
  NotusDocument _content;
  bool _isFavorite = false;

  void initState() {
    print('init');

    _title = widget.note.name;
    _content = widget.note.content;
    _isFavorite = widget.note.isFavorite;

    _controller = ZefyrController(_content);
    _focusNode = FocusNode();

    _controller.addListener(() {
      _content = _controller.document;
    });

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() async {

    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.paused)
      _save();
  }


  Future<void> _save() async {

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

  Future<bool> _onBackPressed() async {
    await _save();
    return true;
  }

  @override
  Widget build(BuildContext context) {

    Widget content = Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: ScrollConfiguration(behavior: ListScrollingWithoutIndicating(), child: ZefyrField(
        controller: _controller,
        height: MediaQuery.of(context).size.height * 0.75,
        focusNode: _focusNode,
        physics: ClampingScrollPhysics(),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(fontStyle: FontStyle.italic)),
      ),
      ),
    );

    /*Widget noteArea = new Container(
      //margin: EdgeInsets.only(bottom: 50.0),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
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
        ));*/

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

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
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
        body: ZefyrScaffold(
          child: content,
        ),
      ),
    );
  }
}
