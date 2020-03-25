import 'package:notes_app/model/Note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const String TABLE_NOTE = "note";
  static const String COLUMN_ID = "id";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_CONTENT = "content";
  static const String COLUMN_FAVORITE = "isFavorite";

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    print("database getter called");

    if(_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'noteDB.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating note table");

        await database.execute(
          "CREATE TABLE $TABLE_NOTE ("
          "$COLUMN_ID INTEGER PRIMARY KEY,"
          "$COLUMN_NAME TEXT,"
          "$COLUMN_CONTENT TEXT,"
          "$COLUMN_FAVORITE INTEGER"
          ")"
        );
      },
    );
  }

  Future<List<Note>> getNotes() async {
    final db = await database;

    var notes = await db.rawQuery(
        "SELECT * FROM $TABLE_NOTE ORDER BY $COLUMN_FAVORITE DESC, $COLUMN_ID ASC"
    );
    List<Note> noteList = List<Note>();

    notes.forEach((currentNote) {
      Note note = Note.fromMap(currentNote);

      noteList.add(note);
    });

    return noteList;
  }

  Future<Note> insert(Note note) async {
    final db = await database;

    note.id = await db.insert(TABLE_NOTE, note.toMap());
    return note;
  }

  Future<int> delete(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_NOTE,
      where: "id = ?",
      whereArgs: [id]
    );
  }

  Future<int> update(Note note) async {
    final db = await database;

    return await db.update(
      TABLE_NOTE,
      note.toMap(),
      where: "id = ?",
      whereArgs: [note.id],
    );
  }
}