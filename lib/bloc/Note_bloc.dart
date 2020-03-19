import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/events/Note_event.dart';
import 'package:notes_app/events/Set_notes.dart';
import 'package:notes_app/events/Update_note.dart';
import 'package:notes_app/events/add_note.dart';
import 'package:notes_app/events/delete_note.dart';
import 'package:notes_app/model/Note.dart';

class NoteBloc extends Bloc<NoteEvent, List<Note>> {

  @override
  List<Note> get initialState => List<Note>();

  @override
  Stream<List<Note>> mapEventToState(NoteEvent event) async* {
    if(event is SetNotes) {
      yield event.noteList;
    }
    else if(event is AddNote) {
      List<Note> newState = List.from(state);
      if(event.newNote != null) {
        newState.add(event.newNote);
      }
      yield newState;
    }
    else if(event is DeleteNote) {
      List<Note> newState = List.from(state);
      newState.removeAt(event.noteIndex);
      yield newState;
    }
    else if(event is UpdateNote) {
      List<Note> newState = List.from(state);
      newState[event.noteIndex] = event.newNote;
      yield newState;
    }
  }
}