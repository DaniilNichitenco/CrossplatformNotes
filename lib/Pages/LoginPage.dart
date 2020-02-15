import 'package:flutter/material.dart';
import 'package:notes_app/Pages/HomePage.dart';
import 'package:notes_app/Styles/Styles.dart';
import 'package:notes_app/Animations/SlideRightRoute.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:notes_app/Animations/Scrolling.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();

  FocusNode myFocusNode;
  final FocusNode firstFocusNode = FocusNode();

  @override
  void initState(){
    super.initState();
    myFocusNode = FocusNode();

  }

  @override
  void dispose(){
    myFocusNode.dispose();
    super.dispose();
  }


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
      textInputAction: TextInputAction.next,
      focusNode: firstFocusNode,
      onFieldSubmitted: (String value) {
        _changeFocus(context, firstFocusNode, myFocusNode);
        },
      controller: emailFieldController,
      style: TextStyle(color: Colors.white),
      decoration: new InputDecoration(
          icon: Icon(Icons.person, color:  Colors.white),
          hintText: 'user123@gmail.com',
          hintStyle: TextStyle(color: Colors.grey),
          labelText: 'E-mail Address',
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: new UnderlineInputBorder(
              borderSide: new BorderSide(
                  color: Colors.grey
              )
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: new BorderSide(color: Colors.white)
          )),
    );

    passwordFormField = new TextFormField(
      focusNode: myFocusNode,
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
      textInputAction: TextInputAction.go,
      onFieldSubmitted: (v){
        if (_formKey.currentState.validate()) {
          Navigator.push(
              context, SlideRightRoute(page: MyHomePage()));
        }
      },
      style: TextStyle(color: Colors.white),
      decoration: new InputDecoration(
          icon: Icon(Icons.lock, color: Colors.white,),
          hintText: 'Password',
          hintStyle: TextStyle(color: Colors.grey),
          labelText: 'Enter your password',
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: new UnderlineInputBorder(
            borderSide: new BorderSide(
              color: Colors.grey
            )
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: new BorderSide(color: Colors.white)
          )),
    );
  }

  //!!!This work not well, gotta check it!!!
  _changeFocus(BuildContext context, FocusNode focusNodeCurrent,
      FocusNode focusNodeNext) {
    focusNodeCurrent.unfocus();
    setState(() => focusNodeCurrent = focusNodeNext);
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
            stops: [0.18, 0.45, 0.7, 9],
            colors: Styles.colorThemeList,
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.06,
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,

          ),
          child: ScrollConfiguration(behavior: ListScrollingWithoutIndicating(), child:
          ListView(
            children: <Widget>[
              Center(
                child: Text(
                  "CrossplatformNotes",
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        blurRadius: 2.0,
                        color: Colors.blueGrey,
                        offset: Offset(1.30, 1.30),
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

                  ),
                ),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.only(top: 40, bottom: 30),
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      shadows: [
                        Shadow(
                          blurRadius: 2.0,
                          color: Colors.blueGrey,
                          offset: Offset(1.20, 1.20),
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
                        height: 72,
                        margin: EdgeInsets.symmetric(
                            horizontal: 50),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(100.0),
                          ),
                          child: new Text(
                            "Login",
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 18),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              Navigator.push(
                                  context, SlideRightRoute(page: MyHomePage()));
                            }
                          },
                          color: Styles.colorTheme,
                        ),
                        padding: EdgeInsets.only(top: 30),

                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 20.0),
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
          ),)
        ),
      ),
    );
  }
}

