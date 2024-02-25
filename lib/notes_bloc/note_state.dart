part of 'note_bloc.dart';

@immutable
class NoteState {
  final List<Note> notes;
  // final bool isLoading;

  const NoteState({
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