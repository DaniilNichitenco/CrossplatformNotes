import 'package:notes_app/model/Note.dart';
import 'package:notes_app/events/Note_event.dart';

class AddNote extends NoteEvent {
  Note newNote;

  AddNote(Note note){
    newNote = note;
  }
}