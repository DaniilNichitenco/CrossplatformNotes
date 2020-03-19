import 'package:notes_app/db/database_provider.dart';

class Note {
  int id;
  String name;
  String content;
  bool isFavorite;

  Note({this.id, this.name, this.content, this.isFavorite});

  Map<String, dynamic> toMap(){
    var map = <String, dynamic> {
      DatabaseProvider.COLUMN_NAME: name,
      DatabaseProvider.COLUMN_CONTENT: content,
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
    content = map[DatabaseProvider.COLUMN_CONTENT];
    isFavorite = map[DatabaseProvider.COLUMN_FAVORITE] == 1;
  }
}