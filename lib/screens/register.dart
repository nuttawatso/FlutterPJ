import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pjflutter/screens/my_service.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
// ตัวแปร
  final allkey = GlobalKey<FormState>();
  String namestring, emailstring, passstring;

//Method
  Widget registerButton() {
    return IconButton(
      icon: Icon(Icons.brightness_7),
      onPressed: () {
        print('click');
      },
    );
  }

  Widget registerButton2() {
    return RaisedButton(
      color: Color.fromRGBO(229, 115, 115, 1),
      child: Text(
        'สมัครสมาชิก',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
      onPressed: () {
        print('click');
        if (allkey.currentState.validate()) {
          allkey.currentState.save();
          print(
            'name = $namestring , email = $emailstring , pass = $passstring',
          );
          RegisterThread();
        }
      },
    );
  }

  Future<void> RegisterThread() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailstring, password: passstring)
        .then((response) {
      print('สมัครสมาชิกสำเร็จ email = $emailstring');
      setupDisplayname();
    }).catchError((response) {
      String title = response.code;
      String message = response.message;
      print('title = $title, massage = $message');
      myAler(title, message);
    });
  }

  Future<Void> setupDisplayname() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.currentUser().then(
      (response) {
        UserUpdateInfo userUpdateInfo = UserUpdateInfo();
        userUpdateInfo.displayName = namestring;
        response.updateProfile(userUpdateInfo);

        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Myservice());
        Navigator.of(context).pushAndRemoveUntil(
            materialPageRoute, (Route<dynamic> route) => false);
      },
    );
  }

  void myAler(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: ListTile(
              leading: Icon(
                Icons.add_alert,
                color: Colors.red,
                size: 48.0,
              ),
              title: Text(
                title,
                style: TextStyle(color: Colors.red),
              ),
            ),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Widget nametext() {
    return TextFormField(
      style: TextStyle(color: Colors.purple),
      decoration: InputDecoration(
        icon: Icon(
          Icons.face,
          color: Colors.red[200],
          size: 40,
        ),
        labelText: 'ชื่อ',
        labelStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        helperText: '',
        helperStyle: TextStyle(
          color: Colors.red,
          fontStyle: FontStyle.italic,
        ),
      ),
      validator: (String valuename) {
        if (valuename.isEmpty) {
          return 'กรุณากรอกชื่อ a-z,A,Z';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        namestring = value.trim();
      },
    );
  }

  Widget email() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.purple),
      decoration: InputDecoration(
        icon: Icon(
          Icons.email,
          color: Colors.red[200],
          size: 40,
        ),
        labelText: 'อีเมล์',
        labelStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        helperText: '',
        helperStyle: TextStyle(
          color: Colors.red,
          fontStyle: FontStyle.italic,
        ),
      ),
      validator: (String valueemail) {
        if (!((valueemail.contains('@') && valueemail.contains('.')))) {
          return 'กรุณากรอกประเภท อีเมล์ เช่น abc@gmail.com';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        emailstring = value.trim();
      },
    );
  }

  Widget password() {
    return TextFormField(
      obscureText: true,
      style: TextStyle(color: Colors.purple),
      decoration: InputDecoration(
        icon: Icon(
          Icons.fingerprint,
          color: Colors.red[200],
          size: 40,
        ),
        labelText: 'รหัสผ่าน',
        labelStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        helperText: '',
        helperStyle: TextStyle(
          color: Colors.red,
          fontStyle: FontStyle.italic,
        ),
      ),
      validator: (String valuepass) {
        if (valuepass.length < 6) {
          return 'กรุณากรอกรหัสอย่างน้อย 6 ตัว';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        passstring = value.trim();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(229, 115, 115, 1),
        title: Text('สมัครสมาชิก'),
        actions: <Widget>[registerButton()],
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Color.fromRGBO(255, 205, 210, 1),
                Color.fromRGBO(255, 235, 238, 1.0)
              ],
              radius: 1.0,
            ),
          ),
          child: Form(
            key: allkey,
            child: ListView(
              padding: EdgeInsets.all(35.0),
              children: <Widget>[
                nametext(),
                email(),
                password(),
                SizedBox(height: 40.0),
                registerButton2(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
