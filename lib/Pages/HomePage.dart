import 'package:flutter/material.dart';
import 'package:notes_app/Animations/SlideRightRoute.dart';
import 'package:notes_app/Pages/NotePage.dart';
import 'package:notes_app/UI_Elements/menuDrawer.dart';
import 'package:notes_app/Styles/Styles.dart';
import 'package:notes_app/UI_Elements/NoteList.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void createNote() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget popupMenu() => PopupMenuButton(
          itemBuilder: (context) {
            List<PopupMenuEntry<Object>> list = [
              PopupMenuItem(
                child: Text("Settings"),
                value: 1,
              ),
              PopupMenuItem(
                child: Text("Profile"),
                value: 2,
              ),
              PopupMenuItem(
                child: Text("Languages"),
                value: 3,
              ),
            ];

            return list;
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
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.022),
        children: <Widget>[NoteList()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              SlideRightRoute(page: NotePage("NewNote", "Your new note")));
        },
        tooltip: 'New note',
        child: Icon(Icons.add),
        backgroundColor: Styles.colorTheme,
      ),
    );
  }
}
