import 'package:flutter/material.dart';
import 'package:notes_app/Pages/HomePage.dart';
import 'package:notes_app/Styles/Styles.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/Animations/SlideRightRoute.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();

  final userEmail = '1';
  final userPass = '1';
  final _formKey = GlobalKey<FormState>();

  TextFormField emailFormField;
  TextFormField passwordFormField;

  _LoginPageState() {
    emailFormField = new TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value.isEmpty) {
          return 'Enter E-mail!';
        }
        if (value != userEmail) {
          return 'Incorrect Email. Please, try again';
        }
        return null;
      },
      autofocus: false,
      controller: emailFieldController,
      decoration: new InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'user123@gmail.com',
          labelText: 'E-mail Address',
          labelStyle: TextStyle(color: Colors.black)),
    );

    passwordFormField = new TextFormField(
      obscureText: true,
      autofocus: false,
      validator: (value) {
        if (value.isEmpty) {
          return 'Enter password!';
        }
        if (value != userPass) {
          return 'Incorrect password. Please, try again';
        }
        return null;
      },
      controller: passwordFieldController,
      decoration: new InputDecoration(
          icon: Icon(Icons.lock),
          hintText: 'Password',
          labelText: 'Enter your password',
          labelStyle: TextStyle(color: Colors.black)),
    );
  }

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
            colors: Styles.colorThemeList,
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.06,
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
          ),
          child: ListView(
            children: <Widget>[
              Center(
                child: Text(
                  "CrossplatformNotes",
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        blurRadius: 7.0,
                        color: Colors.green[900],
                        offset: Offset(2.0, 2.0),
                      )
                    ],
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 30,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "GROWTH * HAPPENS * TODAY",
                  style: TextStyle(
                    color: Colors.white,
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
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
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
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    emailFormField,
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: passwordFormField,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot your password?",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    new ListTile(
                      title: Container(
                        height: MediaQuery.of(context).size.width * 0.2,
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.15),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(100.0),
                          ),
                          child: new Text(
                            "Login",
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              Navigator.push(
                                  context, SlideRightRoute(page: MyHomePage()));
                            }
                          },
                          color: colorTheme,
                        ),
                        padding: EdgeInsets.only(top: 30),

                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15.0),
                        child: Center(
                        child: GoogleSignInButton(
                        text: "  Sign in with Google   ", //отступы нужны для выравнивания
                        borderRadius: 10.0,
                        darkMode: true,
                        onPressed: (){},
                      ),
                    )
                    ),
                    Center(
                      child: FacebookSignInButton(
                        text: "Sign in with Facebook",
                        onPressed: (){},
                        borderRadius: 10.0,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
