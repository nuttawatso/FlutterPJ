import 'package:flutter/material.dart';
import 'album.dart';
 
class AlbumCell extends StatelessWidget {
  const AlbumCell(this.context, this.album);
  @required
  final Album album;
  final BuildContext context;
 
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromRGBO(255, 205, 210,1),
      child: Padding(
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 10.0),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: ClipRRect(
                  borderRadius : BorderRadius.circular(10.0),
                  child: FadeInImage.assetNetwork(
                    placeholder: "images/logo-asura-v4.png",
                   image: album.thumbnailUrl,
                    width: 350,
                    height: 350,
                  ),
                  
                ),
              ),
              Padding(
                padding: EdgeInsets.all(1.0),
                child: Center(
                  child: Text(
                    album.title,
                    style:TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,),
                    maxLines: 100,
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 