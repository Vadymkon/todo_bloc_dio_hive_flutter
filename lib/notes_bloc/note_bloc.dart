import 'package:bloc/bloc.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_bloc_dio_hive_flutter/boxes.dart';

import '../note.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  // final NotesReposBloc noteRepository;
  final Box<Note> _noteBox = boxNotes;

  //(this.noteRepository)
  NoteBloc() : super(const NoteState()) {
    on<NoteAddEvent>(_onAddNote);
    on<NoteRemoveEvent>(_onRemoveNote);
    on<NoteReadyChangeEvent>(_onChangeReadyNote);
    on<NoteCategoryChangeEvent>(_onChangeCategoryNote);
    on<NoteFetchEvent>(_onFetchNote);
    on<NoteFilteredEvent>(_onFilteredNote);

    add(NoteFetchEvent()); //get data
  }

  _onAddNote(NoteAddEvent event, Emitter<NoteState>emit) async {
    if (event.name.trim().isEmpty) return; // do not add new note if name is empty
    // emit(state.copyWith(isLoading: false));
    //add new note
    final Note newNote = Note( //add a new element
        name: event.name,
        descr: event.descr,
        id: Crypt.sha512(event.name).toString().substring(0,6) ); //get unic ID
    await _noteBox.put(newNote.id, newNote); //put in box value

    emit(NoteState(notes: _noteBox.values.toList())); //new list is on
  }

  _onRemoveNote(NoteRemoveEvent event, Emitter<NoteState>emit) {
    _noteBox.delete(event.id);
    emit(NoteState(notes: _noteBox.values.toList())); //new list is on
  }

  _onChangeReadyNote(NoteReadyChangeEvent event, Emitter<NoteState>emit) {
    final Note? note = _noteBox.get(event.id); //get example of this note
    if (note == null) return; //check
    note.ready = event.ready; //edit parameter
    _noteBox.put(event.id, note); //put new value

    emit(NoteState(notes: _noteBox.values.toList())); //new list is on
  }

  //analog for category
  _onChangeCategoryNote(NoteCategoryChangeEvent event, Emitter<NoteState>emit) {
    final Note? note = _noteBox.get(event.id); //get example of this note
    if (note == null) return; //check
    note.category = event.category; //edit parameter
    _noteBox.put(event.id, note); //put new value


    emit(NoteState(notes: _noteBox.values.toList()));
  }

  //get data
  _onFetchNote (NoteFetchEvent event, Emitter<NoteState> emit) async {
    // emit(state.copyWith(isLoading: true));

    emit(NoteState(notes: _noteBox.values.toList()));
  }

  //filter list
  _onFilteredNote(NoteFilteredEvent event, Emitter<NoteState>emit) {
    if (event.category == null && event.ready == null) return; //obvious script for exit
    List<Note> notes = _noteBox.values.toList(); //get original DB

    //filter 1 - category
    if (event.category?.trim().length != 0) { //isNotEmpty (yep, we're using ==0 instead, bcs in other way we need to rebuild big part of logic)
      notes = notes.where((element) => element.category == event.category).toList();
    }
    //filter 2 - ready
    if (event.ready?.trim().length != 0)
      {
        bool readyness = false;
        if (event.ready == 'ready') readyness = true;
        notes = notes.where((element) => element.ready == readyness).toList();
      }

    emit(NoteState(notes: notes));
  }
}
