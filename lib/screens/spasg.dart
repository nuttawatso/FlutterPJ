import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'home.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 1,
        navigateAfterSeconds:Home(),
        title: Text(
          'Asura Online',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0 ,
            color: Colors.white ,fontStyle:FontStyle.italic),
        ),
        image: Image.asset("images/logo-asura-v4.png"),
        backgroundColor: Color.fromRGBO(255, 205, 210,1),
        styleTextUnderTheLoader: TextStyle(color: Colors.white),
        photoSize: 150.0,
        loaderColor: Colors.black
        );
  }
}