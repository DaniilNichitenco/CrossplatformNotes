import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ListCard.dart';
import 'popup.dart';
import 'popup_content.dart';

void main() => runApp(MyApp());
Color colorTheme = Color.fromARGB(255, 33, 39, 97);
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
    Widget searchBar = Container(
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.001, right: 0),
        padding: EdgeInsets.zero,
        height: MediaQuery.of(context).size.height * 0.045,
        color: colorTheme,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
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
                hintText: "Search",
              ),
            ),
          ),
        ));

    return Scaffold(
      appBar: AppBar(
        title: searchBar,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_alert),
            tooltip: "Show alerts",
            iconSize: 22,
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
              tooltip: "Settings"),
        ],
        backgroundColor: colorTheme,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 5, left: 0, top: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ListCard(),
                  ListCard(
                      Colors.green,
                      "Blablabla",
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("12345"),
                          Text("6789"),
                          Text("0")
                        ],
                      ))
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(right: 0, left: 5, top: 10),
                child: Column(
                  children: <Widget>[
                    ListCard(Colors.yellow),
                    ListCard(Colors.blue),
                    ListCard(Colors.red),
                    ListCard(Colors.green),
                  ],
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
      showPopup(context, _newNoteBody(), 'Creating new note');
    },
    tooltip: 'New note',
    child: Icon(Icons.add),
        backgroundColor: colorTheme,
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
              backgroundColor: colorTheme,
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

    Color bgcolor = Color.fromARGB(100, 149, 159, 223);

    Widget inputName = Container(
      color: Color.fromARGB(0, 149, 159, 223),
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
            top: MediaQuery.of(context).size.height * 0.02
        ),
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
    /*Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.015),
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, right: MediaQuery.of(context).size.width * 0.1),
      child: TextField(
        textInputAction: TextInputAction.search,
        style: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.height * 0.022),
        decoration: InputDecoration(
          filled: true,
          contentPadding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.009,
              left: MediaQuery.of(context).size.width * 0.02,
              bottom: MediaQuery.of(context).size.height * 0.00001),
          border: InputBorder.none,
          hintText: "Enter note's name",
        ),
      ),
    );*/

    return Container(
      color: bgcolor,
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
      child: Column(
        children: <Widget>[Center(
          child: Text("Name your note:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.height * 0.03), ),
        ),
          inputName,
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01, top: MediaQuery.of(context).size.height * 0.01,),
            margin: EdgeInsets.only(right: 0.0, top: 2),
            child: IconButton(
              padding: EdgeInsets.all(0.0),
              iconSize: MediaQuery.of(context).size.width * 0.13,
              onPressed: (){
                try{
                  Navigator.pop(context); // close the popup
                } catch (e){}
              },
              icon: Icon(Icons.check_circle, color: colorTheme,),
            ),
          ),
          /*Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, top: MediaQuery.of(context).size.height * 0.01,),
                margin: EdgeInsets.only(right: 0.0),
                child: IconButton(
                  padding: EdgeInsets.all(0.0),
                  iconSize: MediaQuery.of(context).size.width * 0.13,
                  onPressed: (){
                    try{
                      Navigator.pop(context); // close the popup
                    } catch (e){}
                  },
                  icon: Icon(Icons.check_circle, color: colorTheme,),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, top: MediaQuery.of(context).size.height * 0.01,),
                margin: EdgeInsets.only(left: 0.0),
                child: IconButton(
                  padding: EdgeInsets.all(0.0),
                  iconSize: MediaQuery.of(context).size.width * 0.13,
                  onPressed: (){
                    try{
                      Navigator.pop(context); // close the popup
                    } catch (e){}
                  },
                  icon: Icon(Icons.cancel, color: colorTheme,),
                ),
              ),
            ],
          )*/
        ],
      ),
    );
  }

}