import 'package:flutter/material.dart';
import 'PostScreen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text("Main Screen")),
            backgroundColor: Colors.redAccent,
          ),
          body: Center(
            child: MainScreen(),
          ),
        ));
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        RaisedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PostScreen() ),
            );
          },
            // textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            child: Container(
              child: Text("GO.."),
            ),
        )
      ],
    ));
  }
}
