part of 'note_bloc.dart';

@immutable
class NoteState {
  final List<Note> notes;

  const NoteState({this.notes = const[]});
}