
part of 'note_bloc.dart';

@immutable
abstract class NoteEvent {}

class NoteAddEvent extends NoteEvent {
  final String name;
  final String descr;

  NoteAddEvent(this.name, this.descr);
}

class NoteRemoveEvent extends NoteEvent {
  final String id;

  NoteRemoveEvent(this.id);
}

class NoteCategoryChangeEvent extends NoteEvent {
  final String id;
  final String category;

  NoteCategoryChangeEvent(this.id, this.category);
}
class NoteReadyChangeEvent extends NoteEvent {
  final String id;
  final bool ready;

  NoteReadyChangeEvent(this.id, this.ready);
}

// class NoteFilteredEvent extends NoteEvent {
//   final String? category;
//   final bool? ready;
//
//   NoteFilteredEvent(this.category, this.ready);
// }