import 'package:flutter/material.dart';
import 'SliderImg.dart';
import 'Skill.dart';
import 'gridview.dart';

class Myservice extends StatefulWidget {
  Myservice({Key key}) : super(key: key);

  @override
  _MyserviceState createState() => _MyserviceState();
}

class _MyserviceState extends State<Myservice> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _widgetOptions = <Widget>[
    GridViewDemo(), 
    SkillPage(), 
    SliderImg(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigationBar(
            items:const <BottomNavigationBarItem> [
               
               BottomNavigationBarItem(
                icon: Icon(Icons.wc),
                title: Text('ตัวละคร',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,

      ),
    )
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.blur_off),
            title: Text('ข้อมูลสกิล',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,

    )
      ),
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.broken_image),
            title: Text('รูปภาพ',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,

    )
      ),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
        backgroundColor: Color.fromRGBO(229, 115, 115, 1),
        // showUnselectedLabels:true,
      ),
    );
  }
}


