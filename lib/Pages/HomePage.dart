import 'package:flutter/material.dart';
import 'package:notes_app/UI_Elements/NoteCard.dart';
import 'package:notes_app/UI_Elements/popup.dart';
import 'package:notes_app/UI_Elements/popup_content.dart';
import 'package:notes_app/UI_Elements/menuDrawer.dart';
import 'package:notes_app/Styles/Styles.dart';

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
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.022),
        children: <Widget>[
          Wrap(
            children: <Widget>[
              NoteCard(Colors.yellow),
              NoteCard(
                Colors.green,
                "Blablablav12",
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[Text("12345"), Text("6789"), Text("0")],
                  )
              ),
              NoteCard(Colors.red),
              NoteCard(Colors.blue),
              NoteCard(Colors.deepOrange),
              NoteCard(Colors.yellow),
              NoteCard(Colors.yellow),
              NoteCard(Colors.yellow),
              NoteCard(Colors.deepOrange),
              NoteCard(Colors.yellow),
              NoteCard(Colors.yellow),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showPopup(context, _newNoteBody(), 'Creating new note');
        },
        tooltip: 'New note',
        child: Icon(Icons.add),
        backgroundColor: Styles.colorTheme,
      ),
    );
  }

  showPopup(BuildContext context, Widget widget, String title,
      {BuildContext popupContext}) {
    Navigator.push(
      context,
      PopupLayout(
        top: MediaQuery.of(context).size.height * 0.1,
        left: 30,
        right: 30,
        bottom: MediaQuery.of(context).size.height * 0.56,
        child: PopupContent(
          content: Scaffold(
            appBar: AppBar(
              title: Text(title),
              backgroundColor: Styles.colorTheme,
              leading: new Builder(builder: (context) {
                return IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    try {
                      Navigator.pop(context); //close the popup
                    } catch (e) {}
                  },
                );
              }),
              brightness: Brightness.light,
            ),
            resizeToAvoidBottomPadding: false,
            body: widget,
          ),
        ),
      ),
    );
  }

  Widget _newNoteBody() {
    Widget inputName = Container(
        color: Color.fromARGB(0, 149, 159, 223),
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.12,
            right: MediaQuery.of(context).size.width * 0.12,
            top: MediaQuery.of(context).size.height * 0.02),
        padding: EdgeInsets.zero,
        height: MediaQuery.of(context).size.height * 0.045,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
          ),
          child: Container(
            child: TextField(
              textInputAction: TextInputAction.search,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.height * 0.022),
              decoration: InputDecoration(
                filled: true,
                contentPadding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.009,
                    left: MediaQuery.of(context).size.width * 0.03,
                    bottom: MediaQuery.of(context).size.height * 0.009),
                border: InputBorder.none,
                hintText: "Enter note's name",
              ),
            ),
          ),
        ));

    return Container(
      color: Color.fromARGB(100, 149, 159, 223),
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              "Name your note:",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.height * 0.03),
            ),
          ),
          inputName,
          Container(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.15),
            child: Row(
              children: <Widget>[
                FlatButton(
                    onPressed: () {
                      try {
                        Navigator.pop(context); // close the popup
                      } catch (e) {}
                    },
                    child: Text(
                      "Create",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.026,
                          color: Colors.black54),
                    )),
                FlatButton(
                    onPressed: () {
                      try {
                        Navigator.pop(context); // close the popup
                      } catch (e) {}
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.026,
                          color: Colors.black54),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
