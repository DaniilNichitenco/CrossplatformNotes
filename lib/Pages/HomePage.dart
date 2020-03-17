import 'package:flutter/material.dart';
import 'package:notes_app/Animations/SlideRightRoute.dart';
import 'package:notes_app/Pages/NotePage.dart';
import 'package:notes_app/UI_Elements/menuDrawer.dart';
import 'package:notes_app/Styles/Styles.dart';
import 'package:notes_app/UI_Elements/NoteList.dart';
import 'package:notes_app/UI_Elements/NoteCard.dart';
import 'package:notes_app/UI_Elements/Note.dart';
import 'package:notes_app/UI_Elements/popup_menu.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void createNote() {
    setState(() {
      NoteList.notes.add(Note(title: 'NewNote', text: 'Your new note'));
      Navigator.push(context,
          SlideRightRoute(page: NotePage(NoteList.notes.last)));
      print(NoteList.notes.last.title);
    });
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

    Widget list = new Wrap(
      children: NoteList.notes.map((note) => NoteCard(
        note: note,
        delete: () {
          setState(() {
            NoteList.notes.remove(note);
          });
        },
      )).toList(),
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
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.022),
        children: <Widget>[list],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNote();
        },
        tooltip: 'New note',
        child: Icon(Icons.add),
        backgroundColor: Styles.colorTheme,
      ),
    );
  }
}
