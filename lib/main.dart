import 'package:flutter/material.dart';
import 'package:notes_app/Life_Cycle/Service_locator.dart';
import 'package:notes_app/Pages/LoginPage.dart';
import 'package:notes_app/Life_Cycle/lifecycle_manager.dart';
//import 'package:notes_app/Pages/home_page.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LifeCycleManager(
      child: MaterialApp(
        //title: 'Crossplatform notes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: LoginPage(),
      ),
    );
  }
}
