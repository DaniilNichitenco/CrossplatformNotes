import 'dart:convert';
import 'package:notes_app/db/database_provider.dart';
import 'package:zefyr/zefyr.dart';

class Note {
  int id;
  String name;
  NotusDocument content;
  bool isFavorite;

  Note({this.id, this.name, this.content, this.isFavorite});

  Map<String, dynamic> toMap(){
    var map = <String, dynamic> {
      DatabaseProvider.COLUMN_NAME: name,
      DatabaseProvider.COLUMN_CONTENT: jsonEncode(content.toJson()).toString(),
      DatabaseProvider.COLUMN_FAVORITE: isFavorite ? 1 : 0,
    };

    if(id != null) {
      map[DatabaseProvider.COLUMN_ID] = id;
    }

    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    name = map[DatabaseProvider.COLUMN_NAME];
    content = NotusDocument.fromJson(jsonDecode(map[DatabaseProvider.COLUMN_CONTENT]));
    isFavorite = map[DatabaseProvider.COLUMN_FAVORITE] == 1;
  }
}