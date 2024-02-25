import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_bloc_dio_hive_flutter/note.dart';
import 'package:todo_bloc_dio_hive_flutter/notes_bloc/note_bloc.dart';
import 'package:todo_bloc_dio_hive_flutter/weather_bloc/weather_bloc.dart';
// import 'package:todo_bloc_dio_hive_flutter/notes_repos_bloc/notes_repos_bloc.dart';

import 'boxes.dart';
import 'screens/main_screen.dart';

void main() async {
  //Hive staff
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  boxNotes = await Hive.openBox<Note>('noteBox');
//Other staff
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // final NotesReposBloc notesReposBloc = NotesReposBloc(); //made another bloc for saving SOLID
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NoteBloc(),
        ),
        BlocProvider(
          create: (context) => WeatherBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TestTask',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
