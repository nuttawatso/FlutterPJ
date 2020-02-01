import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pjflutter/screens/home.dart';
import 'service.dart';
import 'album.dart';
import 'gridcell.dart';
import 'details.dart';
import 'dart:async';
 
class GridViewDemo extends StatefulWidget {
  GridViewDemo() : super();
 
  final String title = "Photos";
 
  @override
  GridViewDemoState createState() => GridViewDemoState();
}
 
class GridViewDemoState extends State<GridViewDemo> {
  //
  StreamController<int> streamController = new StreamController<int>();

 
  gridview(AsyncSnapshot<List<Album>> snapshot) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: snapshot.data.map(
          (album) {
            return GestureDetector(
              child: GridTile(
                child: AlbumCell(context, album),
              ),
              onTap: () {
                goToDetailsPage(context, album);
              },
            );
          },
        ).toList(),
      ),
    );
  }
 
  goToDetailsPage(BuildContext context, Album album) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) => GridDetails(
              curAlbum: album,
            ),
      ),
    );
  }
 
  circularProgress() {
    return Center(
      child: const CircularProgressIndicator(),
    );
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
          backgroundColor: Color.fromRGBO(229, 115, 115, 1),
          title: Text("ตัวละคร", style: TextStyle(color: Colors.white)),
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: FutureBuilder<List<Album>>(
              future: Services.getPhotos(),
              builder: (context, snapshot) {
                // not setstate here
                //
                if (snapshot.hasError) {
                  return Text('Error ${snapshot.error}');
                }
                //
                if (snapshot.hasData) {
                  streamController.sink.add(snapshot.data.length);
                  // gridview
                  return gridview(snapshot);
                }
 
                return circularProgress();
              },
            ),
          ),
        ],
      ),
    );
  }
 
  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }
}