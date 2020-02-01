

class Album {
  int albumId;
  int id;
  String title;
  String text;
  String data;
  String url;
  String thumbnailUrl;
 
  Album({this.albumId, this.id, this.title,this.text,this.data, this.url, this.thumbnailUrl});
 
  // Return object from JSON //
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        albumId: json['albumId'] as int,
        id: json['id'] as int,
        title: json['title'] as String,
        text: json['text'] as String,
        data: json['data'] as String,
        url: json['url'] as String,
        thumbnailUrl: json['thumbnailUrl'] as String);
  }
}