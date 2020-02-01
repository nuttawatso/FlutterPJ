import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pjflutter/screens/home.dart';


class SliderImg extends StatefulWidget {
  SliderImg() : super();
 
  final String title = "Carousel Demo";
 
  @override
  _SliderImgState createState() => _SliderImgState();
}
 
class _SliderImgState extends State<SliderImg> {
  //
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
  //
  CarouselSlider carouselSlider;
  int _current = 0;
  List imgList = [
    'https://asura.gameindy.com/wiki/images/4/4d/MAGICIAN.png',
    'https://asura.gameindy.com/wiki/images/2/2b/SHAMAN.png',
    'https://asura.gameindy.com/wiki/images/5/54/ORACLE.png',
    'https://asura.gameindy.com/wiki/images/e/e6/RANGER.png',
    'https://asura.gameindy.com/wiki/images/6/62/PALADIN.png',
    'https://asura.gameindy.com/wiki/images/c/c4/BERSERKER.png',
    'https://asura.gameindy.com/wiki/images/5/58/ASSASIN.png'
  ];
 
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 205, 210,1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(229, 115, 115, 1),
        actions: <Widget>[signoutbutton()],
        title: Text("รูปภาพตัวละคร"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            carouselSlider = CarouselSlider(
              height: 580.0,
              initialPage: 0,
              enlargeCenterPage: true,
              autoPlay: true,
              reverse: false,
              enableInfiniteScroll: true,
              autoPlayInterval: Duration(seconds: 3),
              // autoPlayAnimationDuration: Duration(milliseconds: 3000),
              pauseAutoPlayOnTouch: Duration(seconds: 3),
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
              items: imgList.map((imgUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 205, 210,1),
                      ),
                      child: Image.network(
                        imgUrl,
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(imgList, (index, url) {
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index ? Colors.redAccent : Colors.green,
                  ),
                );
              }),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  onPressed: goToPrevious,
                  child: Text("<"),
                ),
                OutlineButton(
                  onPressed: goToNext,
                  child: Text(">"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
 
  goToPrevious() {
    carouselSlider.previousPage(
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }
 
  goToNext() {
    carouselSlider.nextPage(
        duration: Duration(milliseconds: 300), curve: Curves.decelerate);
  }
}