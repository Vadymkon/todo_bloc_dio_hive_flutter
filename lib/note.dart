import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Note {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String descr;
  @HiveField(2)
  final String id;
  @HiveField(3)
  late bool ready;
  @HiveField(4)
  late String category;

  Note({
    required this.name,
    required this.descr,
    required this.id,
    this.ready = false,
    this.category = ""
  });
}

//Class for Notes