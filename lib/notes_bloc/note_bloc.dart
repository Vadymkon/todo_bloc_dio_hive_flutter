
import 'package:bloc/bloc.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/cupertino.dart';

import '../note.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  // final NotesReposBloc noteRepository;
  //(this.noteRepository)
  NoteBloc() : super(const NoteState()) {
    on<NoteAddEvent>(_onAddNote);
    on<NoteRemoveEvent>(_onRemoveNote);
    on<NoteReadyChangeEvent>(_onChangeReadyNote);
    on<NoteCategoryChangeEvent>(_onChangeCategoryNote);
    // on<NoteFilteredEvent>(_onFilteredNote);
  }

//TODO: adaptize all staff for Hive

  _onAddNote(NoteAddEvent event, Emitter<NoteState>emit) {
    if (event.name.trim().isEmpty) return; // do not add new note if name is empty
    //add new note
    List<Note> notes = [];
    notes.addAll(state.notes);//make a copy of list for adding
    notes.add(Note( //add a new element
        name: event.name,
        descr: event.descr,
        id: Crypt.sha512(event.name).toString().substring(0,6) )); //get unic ID
    emit(NoteState(notes: notes)); //new list is on
  }

  _onRemoveNote(NoteRemoveEvent event, Emitter<NoteState>emit) {
    List<Note> notes = [];
    notes.addAll(state.notes);//make a copy of list for adding
    notes.removeWhere((element) => element.id == event.id); //remove note by id
    emit(NoteState(notes: notes));
  }

  _onChangeReadyNote(NoteReadyChangeEvent event, Emitter<NoteState>emit) {
    int index = state.notes.indexWhere((element) => element.id == event.id); //get index of element
    if (index == -1) return; //safety
    List<Note> notes = [];
    notes.addAll(state.notes);//make a copy of list for adding
    notes[index].ready = event.ready; // change ready-state
    emit(NoteState(notes: notes));
  }

  _onChangeCategoryNote(NoteCategoryChangeEvent event, Emitter<NoteState>emit) {
    int index = state.notes.indexWhere((element) => element.id == event.id); //index with same if
    if (index == -1) return; //safety

    List<Note> notes = [];
    notes.addAll(state.notes);//make a copy of list for adding
    notes[index].category = event.category; //change
    emit(NoteState(notes: notes));
  }

  // _onFilteredNote(NoteFilteredEvent event, Emitter<NoteState>emit) {}
}
