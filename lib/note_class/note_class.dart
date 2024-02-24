class Note {
  final String name;
  final String descr;
  final String id;
  late bool ready;
  late String category;

  Note({
    required this.name,
    required this.descr,
    required this.id,
    this.ready = false,
    this.category = ""
  });
}