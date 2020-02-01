import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'jsonSkill.dart';
import 'Skilldetail.dart';

class SkillPage extends StatefulWidget {
  @override
  SkillPageState createState() {
    return new SkillPageState();
  }
}

class SkillPageState extends State<SkillPage> {
  var url =
      "https://raw.githubusercontent.com/nuttawatso/nuttyjson/master/db.json";
  PokeHub pokeHub;

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedJson);
    print(pokeHub.toJson());
    setState(() {});
  }
    Widget signoutbutton() {
    return IconButton(
      icon: Icon(
        Icons.exit_to_app,
      ),
      tooltip: 'Signout',
      onPressed: () {
        myalert();
      },
    );
  }

  void myalert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('คุณแน่ใจ ?'),
            content: Text('คุณต้องการออกจากระบบ?'),
            actions: <Widget>[
              cancelbutton(),
              okbutton(),
            ],
          );
        });
  }

  Widget okbutton() {
    return FlatButton(
      child: Text('ยืนยัน'),
      onPressed: () {
        Navigator.of(context).pop();
        processsignout();
      },
    );
  }

  Future<void> processsignout() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut().then((response) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => Home());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    });
  }

  Widget cancelbutton() {
    return FlatButton(
      child: Text('ยกเลิก'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[signoutbutton()],
        title: Text("ข้อมูลสกิล"),
        backgroundColor: Color.fromRGBO(229, 115, 115, 1),
      ),
      body: pokeHub == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: pokeHub.pokemon
                  .map((poke) => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PokeDetail(
                                          pokemon: poke,
                                        )));
                          },
                          child: Hero(
                            tag: poke.img,
                            child: Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                       height: 60.0,
                                       width: 60.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(poke.img),
                                            )
                                            ),
                                  ),
                                  Text(
                                    poke.name,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              color: Color.fromRGBO(255, 205, 210,1),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
    
    );
  }
}