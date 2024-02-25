part of 'note_bloc.dart';

@immutable
class NoteState {
  final List<Note> notes;
  final String filter1;
  final String filter2;
  // final bool isLoading;

  const NoteState( {
  this.filter1 = '',
  this.filter2 = '',
    this.notes = const[],
    // this.isLoading = false,
  });

  // NoteState copyWith({
  //   List<Note>? notes,
  //   bool isLoading = false
  // }) {
  //   return NoteState(
  //     notes: notes ?? this.notes,
  //     isLoading: isLoading,
  //   );
  // }
}