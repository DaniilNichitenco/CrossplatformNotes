import 'package:notes_app/events/Note_event.dart';

class DeleteNote extends NoteEvent {
  int noteIndex;

  DeleteNote(int index) {
    noteIndex = index;
  }
}