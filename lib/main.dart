import 'package:flutter/material.dart';
import 'package:notes_app/login_page.dart';
import 'home_page.dart';

void main() => runApp(MyApp());
Color colorTheme = Color.fromARGB(255, 33, 39, 97);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Crossplatform notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}
