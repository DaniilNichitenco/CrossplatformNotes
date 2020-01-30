import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/Styles/Styles.dart';

class MenuDrawer extends StatefulWidget {
  MenuDrawer({Key key}) : super(key: key);

  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Container(
                    width: 70,
                    height: 70,
                    color: Colors.white,
                    alignment: Alignment(0.0, 0.0),
                    child: Image.asset('images/person_black.png'),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: 18.0),
                    child: Wrap(
                      spacing: 15.0,
                      children: <Widget>[
                        Text(
                          "FIrst name",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Last name",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )),
                Container(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    "User123@gmail.com",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Styles.colorTheme,
            ),
          ),
          ListTile(
            title: Text("Profile"),
            onTap: () {},
          ),
          ListTile(title: Text("Settings"), onTap: () {}),
        ],
      ),
    );
  }
}
