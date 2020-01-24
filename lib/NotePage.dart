import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
  int _selectedIndex = 0;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget bottom = new BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.color_lens),
          title: Text('Theme'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          title: Text('Business'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          title: Text('School'),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );

    Widget writtingArea = new Container(
      child: TextField(
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Write here",
            hintStyle: TextStyle(fontStyle: FontStyle.italic)
        ),
      ),
    );

    Widget noteArea = new Container(
      child: ListView(
        children: ListTile.divideTiles(
            context: context,
            tiles: [
              ListTile(
                title: Container(
                  child: Text(noteTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                ),
              ),
              ListTile(
                title: writtingArea,
              ),
            ]
        ).toList(),
      )
    );

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
      body: noteArea,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Create note',
        child: Icon(Icons.add),
        backgroundColor: colorTheme,
      ),
      bottomNavigationBar: bottom,
    );
  }
}