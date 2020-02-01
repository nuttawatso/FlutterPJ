import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pjflutter/screens/home.dart';
import 'package:pjflutter/screens/my_service.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  //ตัวแปร
  final formkey = GlobalKey<FormState>();
  String emailstring, passstring;

  //method

  Widget content() {
    return Center(
      child: Form(
        key: formkey,
        child: Column(
          children: <Widget>[
            textemail(),
            textpassword(),
          ],
        ),
      ),
    );
  }

  Widget showlogo() {
    return Container(
      child: Image.asset('images/character_1.png'),
    );
  }
  Widget textemail() {
    return Container(
      width: 400.0,
      child: TextFormField(
        // keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(
            Icons.email,
            size: 36.0,
            color: Colors.red[200],
          ),
          labelText: 'email : ',
          labelStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        ),
        onSaved: (String value) {
          emailstring = value.trim();
        },
      ),
    );
  }
  Widget textpassword() {
    return Container(
      width: 400.0,
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            size: 36.0,
            color: Colors.red[200],
          ),
          labelText: 'password : ',
          labelStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        ),
        onSaved: (String value) {
          passstring = value.trim();
        },
      ),
    );
  }

  Future<void> checkauthen() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .signInWithEmailAndPassword(email: emailstring, password: passstring)
        .then((response) {
      print('เข้าสู่ระบบสำเร็จ email = $emailstring');
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => Myservice());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }).catchError((response) {
      String title = response.code;
      String message = response.message;
      print('title = $title, massage = $message');
      myAler(title, message);
    });
  }

  Widget showtitle(String title) {
    return ListTile(
      leading: Icon(
        Icons.add_alert,
        size: 48.0,
        color: Colors.red,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.red,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget okbutton() {
    return FlatButton(
      child: Text('OK'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  void myAler(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: showtitle(title),
            content: Text(message),
            actions: <Widget>[okbutton()],
          );
        });
  }

  Widget registerButton2() {
    return Container(
      constraints: BoxConstraints.expand(height: 50),
      child: RaisedButton(
        color: Color.fromRGBO(229, 115, 115, 1),
        child: Text(
          'เข้าสู่ระบบ',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        onPressed: () {
          formkey.currentState.save();
          print('email : $emailstring, pass:$passstring');
          checkauthen();
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 205, 210,1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(229, 115, 115, 1),
        title: Text("เข้าสู่ระบบ", style: TextStyle(color: Colors.white)),
      ),

      body: SingleChildScrollView(
        child: Container(
            child: Center(
          child: Container(
              margin: EdgeInsets.all(32),
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  showlogo(),
                  content(),
                  SizedBox(height: 40.0),
                  registerButton2(),
                ],
              )),
        )),
      ),
    );
  }
}
