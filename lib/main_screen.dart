import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_dio_hive_flutter/categories_list.dart';
import 'package:todo_bloc_dio_hive_flutter/notes_bloc/note_bloc.dart';
import 'package:todo_bloc_dio_hive_flutter/popup_menus/add_note.dart';
import 'package:todo_bloc_dio_hive_flutter/popup_menus/change_category_menu.dart';

//TODO: StateSafe (SOLID safety)
//TODO: Filtering (another event)
//TODO: WeatherBloc & WeatherWidget

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    final notes = context.select((NoteBloc nbloc) => nbloc.state.notes);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: const Text("ToDosApp"),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Filters', style: TextStyle(fontSize: 30),),
            const DropdownMenu(dropdownMenuEntries: readyStates),
            const DropdownMenu(dropdownMenuEntries: categories),
            Container(
              constraints: BoxConstraints(maxHeight: 420),
              child: BlocBuilder<NoteBloc, NoteState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      // if (state.isLoading)
                      //   const CircularProgressIndicator(),
                      if (state.notes.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {changeReadyState(context, notes[index].category,notes[index].id);},
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black, width: 0.5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            leading: IconButton(
                              onPressed: () {
                                BlocProvider.of<NoteBloc>(context).add(NoteRemoveEvent(notes[index].id));
                              },
                              icon: Icon(Icons.delete),
                            ),
                            title: Text(notes[index].name),
                            subtitle: Text(notes[index].descr),
                            trailing: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 100),
                              child: Checkbox(
                                checkColor: Colors.green,
                                value: notes[index].ready,
                                onChanged: (bool? value) {
                                  BlocProvider.of<NoteBloc>(context).add(NoteReadyChangeEvent(notes[index].id, value!));
                                },
                              )//Text(notes[index].category),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNoteMenu(context);
        },
        tooltip: 'Add new element',
        child: const Icon(Icons.add),
      ),
    );
  }
}

