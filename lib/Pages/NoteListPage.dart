import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/events/Update_note.dart';
import 'package:notes_app/events/delete_note.dart';
import 'package:notes_app/UI_Elements/menuDrawer.dart';
import 'package:notes_app/Styles/Styles.dart';
import 'package:notes_app/model/NoteCard.dart';
import 'package:notes_app/events/add_note.dart';
import 'package:notes_app/model/Note.dart';
import 'package:notes_app/UI_Elements/popup_menu.dart';
import 'package:notes_app/bloc/Note_bloc.dart';
import 'package:notes_app/db/database_provider.dart';
import 'package:notes_app/events/Set_notes.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {

    super.initState();

  }
  void _updateDB() {

    DatabaseProvider.db.getNotes().then(
          (noteList) {
        BlocProvider.of<NoteBloc>(context).add(SetNotes(noteList));
      },
    );

  }

 void createNote(BuildContext context) {

    String _name = "Note";
    NotusDocument _content = NotusDocument.fromDelta(Delta()..insert("Something\n"));
    bool _isFavorite = false;

    final _formKey = GlobalKey<FormState>();
    String _newTitle;

    Widget renameField = TextFormField(
      initialValue: _name,
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
            _name = _newTitle;

            Note note = Note(
                name: _name,
                content: _content,
                isFavorite: _isFavorite
            );

            DatabaseProvider.db.insert(note).then(
                    (storedNote) {
                  BlocProvider.of<NoteBloc>(context).add(
                    AddNote(storedNote),
                  );
                }
            );

          });
          Navigator.of(context).pop();
        }
      },
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: new BorderSide(color: Colors.grey)),
          focusedBorder: UnderlineInputBorder(
              borderSide: new BorderSide(color: Colors.black)),
          hintText: "Note's name...",
          hintStyle: TextStyle(fontStyle: FontStyle.italic)),
    );

    Widget cancelButton = FlatButton(
      child: Text('Cancel'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget renameButton = FlatButton(
      child: Text('Create'),
      onPressed: () {
        if(_formKey.currentState.validate())
        {
          setState(() {

            _name = _newTitle;

            Note note = Note(
                name: _name,
                content: _content,
                isFavorite: _isFavorite
            );

            DatabaseProvider.db.insert(note).then(
                    (storedNote) {
                  BlocProvider.of<NoteBloc>(context).add(
                    AddNote(storedNote),
                  );
                }
            );

          });
          Navigator.of(context).pop();
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text('Creating a note'),
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

  void choiceAction(String choice){
    switch(choice){
      case PopupMenu.Settings:
        {
          print(choice);
          break;
        }
      case PopupMenu.Profile:
        {
          print(choice);
          break;
        }
      case PopupMenu.Languages:
        {
          print(choice);
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {

    _updateDB();

    Widget popupMenu() => PopupMenuButton<String>(
      onSelected: choiceAction,
      itemBuilder: (context) {
        return PopupMenu.homePageList.map((String choice){
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
      elevation: 5,
    );

    Widget searchBar = Container(
      padding: EdgeInsets.only(left: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: TextField(
                textInputAction: TextInputAction.search,
                style: TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search",
                  hintStyle:
                  TextStyle(color: Color.fromARGB(255, 200, 200, 200)),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      drawer: MenuDrawer(),
      appBar: AppBar(
        title: searchBar,
        actions: <Widget>[
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
      body: Container(
        child: BlocConsumer<NoteBloc, List<Note>>(
          builder: (context, noteList) {
            return StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                itemCount: noteList.length,
                reverse: false,
              // ignore: missing_return
                itemBuilder: (BuildContext context, int index){
                  Note note = noteList[index];

                    return NoteCard(
                      note: note,
                      delete: () {
                        setState(() {
                          DatabaseProvider.db.delete(note.id).then(
                                  (_) {
                                BlocProvider.of<NoteBloc>(context).add(
                                    DeleteNote(index)
                                );
                              }
                          );
                        });
                      },
                      index: index,
                    );
                },
                staggeredTileBuilder: (int index) =>
                    StaggeredTile.fit(2),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            );
          },
          listener: (BuildContext context, noteList) {},
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNote(context);
        },
        tooltip: 'New note',
        child: Icon(Icons.add),
        backgroundColor: Styles.colorTheme,
      ),
    );
  }
}
