import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:weather/HomePage.dart';
void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 4,
      navigateAfterSeconds: new HomePage(),
      title: new Text('Welcome',
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 26.0,
        color: Colors.purple,
       ),
      ),
      image: Image.asset("images/pic1.png"),
      backgroundColor: Colors.white,
      photoSize: 150.0,
    );
  }
}

