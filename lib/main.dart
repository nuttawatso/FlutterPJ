import 'package:flutter/material.dart';
import 'package:pjflutter/screens/home.dart';
import 'package:pjflutter/screens/spasg.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPage(),
    );
  }
}
