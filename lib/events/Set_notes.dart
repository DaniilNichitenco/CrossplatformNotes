import 'package:notes_app/model/Note.dart';
import 'package:notes_app/events/Note_event.dart';

class SetNotes extends NoteEvent {
  List<Note> noteList;

  SetNotes(List<Note> notes) {
    noteList = notes;
  }
}