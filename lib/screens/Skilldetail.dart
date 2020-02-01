import 'package:flutter/material.dart';
import 'jsonSkill.dart';

class PokeDetail extends StatelessWidget {
  final Pokemon pokemon;

  PokeDetail({this.pokemon});

  bodyWidget(BuildContext context) => Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height / 2.5,
            width: MediaQuery.of(context).size.width - 25,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.13,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                
                children: <Widget>[
                    Hero(
                      tag: pokemon.img,
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover, image: NetworkImage(pokemon.img))),
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(pokemon.name,style:TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                  Text("${pokemon.height}"),
                  Text("${pokemon.weight}"),
                   Text("${pokemon.candy}"),
                ],
              ),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 205, 210,1),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(229, 115, 115, 1),
        title: Text(pokemon.name),
      ),
      body: bodyWidget(context),
    );
  }
}