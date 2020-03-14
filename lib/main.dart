import 'package:flutter/material.dart';
import 'package:notes_app/Pages/HomePage.dart';
import 'package:notes_app/Pages/LoginPage.dart';
//import 'package:notes_app/Pages/home_page.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Crossplatform notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}
