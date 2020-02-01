import 'package:flutter/material.dart';
import 'album.dart';
 
class GridDetails extends StatefulWidget {
  final Album curAlbum;
  GridDetails({@required this.curAlbum});
 
  @override
  GridDetailsState createState() => GridDetailsState();
}
 
class GridDetailsState extends State<GridDetails> {
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(239, 154, 154, 1.0) ,
     
      body: SafeArea(
              child: Container(
                  decoration: BoxDecoration(
             gradient: RadialGradient(
              colors: [Colors.white, Color.fromRGBO(239, 154, 154, 1.0)],
              radius: 1.0,
            ),
          ),
          
          alignment: Alignment.center,
          margin: EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FadeInImage.assetNetwork(
                  placeholder: "images/logo-asura-v4.png",
                  image: widget.curAlbum.url, 
                  width: 450,
                  height: 550,
                  fit: BoxFit.fitWidth,
              ),
              Text("อาชีพ: ${widget.curAlbum.title }",style:TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
              Text("${widget.curAlbum.data }"),
              SizedBox(
                height: 30.0,
              ),
              OutlineButton(
                child: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}