import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pjflutter/screens/authen.dart';
import 'package:pjflutter/screens/my_service.dart';
import 'package:pjflutter/screens/register.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // method
  @override
  void initState() {
    super.initState();
    checkstatus();
  }

  Future<void> checkstatus() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    if (firebaseUser != null) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => Myservice());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }
  }

  Widget showlogo() {
    return Container(
      width: 200.0,
      height: 200.0,
      child: Image.asset('images/tiger.png'),
    );
  }

  Widget showAppName() {
    return Text(
      'Aura Online',
      style: TextStyle(
        fontSize: 60.0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        fontFamily: 'Sacramento',
      ),
    );
  }

  Widget signInButton() {
    return OutlineButton(
      color: Colors.blue[600],
      child: Text('SINGIN' ,style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),) ,
      onPressed: () {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Authen());
        Navigator.of(context).push(materialPageRoute);
      },
    );
  }

  Widget signUpButton() {
    return OutlineButton(
      child: Text('SINGUP',style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
      onPressed: () {
        print('กดได้');

        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Register());
        Navigator.of(context).push(materialPageRoute);
      },
    );
  }

  Widget showButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        signInButton(),
        SizedBox(
          width: 5.0,
        ),
        signUpButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Color.fromRGBO(229, 115, 115,0), Color.fromRGBO(239, 154, 154, 1.0)],
              radius: 1.0,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                showlogo(),
                showAppName(),
                SizedBox(height: 10.0),
                showButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
