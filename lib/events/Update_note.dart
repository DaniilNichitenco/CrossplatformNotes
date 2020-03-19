import 'package:notes_app/model/Note.dart';
import 'package:notes_app/events/Note_event.dart';

class UpdateNote extends NoteEvent {
  Note newNote;
  int noteIndex;

  UpdateNote(int index, Note note) {
    newNote = note;
    noteIndex = index;
  }
}