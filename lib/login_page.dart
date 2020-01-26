import 'package:flutter/material.dart';
import 'package:notes_app/home_page.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/SlideRightRoute.dart';

class LoginPage extends StatefulWidget{

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

 // final _formKey = GlobalKey<FormState>();

  final emailFormField =new TextFormField(
    keyboardType: TextInputType.emailAddress,
    autofocus: false,
    decoration: new InputDecoration(
      icon: Icon(Icons.person),
      hintText: 'user123@gmail.com',
      labelText: 'E-mail Address',
      labelStyle: TextStyle(
        color: Colors.black
      )
    ),
  );

  final passwordFormField = new TextFormField(
   // key: _formKey,
    obscureText: true,
    autofocus: false,
    decoration: new InputDecoration(
      icon: Icon(Icons.lock),
      hintText: 'Password',
      labelText: 'Enter your password',
        labelStyle: TextStyle(
            color: Colors.black
        )
    ),
  );

  List<Color> colorThemeList = [
    Color.fromARGB(255, 65, 35, 182),
    Color.fromARGB(255, 70, 25, 172),
    Color.fromARGB(255, 75, 25, 162),
    Color.fromARGB(255, 80, 25, 152),
  ];



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        // Add box decoration
        decoration: BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0.25, 0.4, 0.6, 8],
            colors: colorThemeList,
          ),
        ),
            child: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width * 0.1,
                right: MediaQuery.of(context).size.width * 0.1,
              ),
              child: ListView(
                children: <Widget>[
                  Center(
                    child: Text("CrossplatformNotes", style: TextStyle(
                      shadows: [
                        Shadow(
                          blurRadius: 7.0,
                          color: Colors.green[900],
                          offset: Offset(2.0, 2.0),
                        )],
                      color: Colors.white,
                      fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 30,),),
                  ),
                  Center(
                    child: Text("GROWTH * HAPPENS * TODAY", style: TextStyle(color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 7.0,
                          color: Colors.green[900],
                          offset: Offset(2.0, 2.0),
                        )
                      ],
                    ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(top: 40, bottom: 20),
                      child: Text("SIGN IN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40,
                        shadows: [
                          Shadow(
                            blurRadius: 7.0,
                            color: Colors.green[900],
                            offset: Offset(2.0, 2.0),
                          )
                        ],
                      ),
                      ),
                    ),
                  ),
                  emailFormField,
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child:  passwordFormField,
                  ),
                  new ListTile(
                    title: Container(
                        height: MediaQuery.of(context).size.width * 0.2,
                        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.15),
                        child:  RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(100.0),
                          ),
                          child: new Text("Login", style: new TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.05),),
                          onPressed: () {
                            Navigator.push(
                                context,
                                SlideRightRoute(page: MyHomePage()));
                          },
                          color: colorTheme,
                        ),
                        padding: EdgeInsets.only(top: 30),
                      ),
                  ),
                ],
              ),
            ),
        ),
    );
  }
}

/*ListView(
                    children: <Widget>[
                      new TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: new InputDecoration(
                          hintText: 'user123@gmail.com',
                          labelText: 'E-mail Address',
                        ),
                      ),
                      new TextFormField(
                        obscureText: true,
                        decoration: new InputDecoration(
                          hintText: 'Password',
                          labelText: 'Enter your password'
                        ),
                      ),
                      new Container(
                        width: MediaQuery.of(context).size.width *0.3,
                        child: RaisedButton(
                          child: new Text("Login", style: new TextStyle(color: Colors.white),),
                          onPressed: () => null,
                          color: colorTheme,
                        ),
                        padding: EdgeInsets.only(top: 30),
                      ),
                    ],
                  )*/