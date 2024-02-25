import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_dio_hive_flutter/categories_list.dart';
import 'package:todo_bloc_dio_hive_flutter/notes_bloc/note_bloc.dart';
import 'package:todo_bloc_dio_hive_flutter/popup_menus/add_note.dart';
import 'package:todo_bloc_dio_hive_flutter/popup_menus/change_category_menu.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    final notes = context.select((NoteBloc nbloc) => nbloc.state.notes);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: const Text("Filter Screen"),

      ),
      body: Center(
        child: Column(
          children: [
            const Text('Filters', style: TextStyle(fontSize: 30),),

            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownMenu(
                    label: const Text('Ready/Not Ready'),
                    dropdownMenuEntries: readyStates,
                    onSelected: (value) {
                      //filter
                      BlocProvider.of<NoteBloc>(context).add(NoteFilteredEvent(null,value));
                    },),
                  DropdownMenu(
                    label: const Text('Group'),
                    dropdownMenuEntries: categories,
                    onSelected: (value) {
                      //filter
                      BlocProvider.of<NoteBloc>(context).add(NoteFilteredEvent(value,null));
                    },),
                ],
              ),
            ),

            Container(
              constraints: const BoxConstraints(maxHeight: 520),
              child: BlocBuilder<NoteBloc, NoteState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      // if (state.isLoading)
                      //   const CircularProgressIndicator(),
                      if (state.notes.isNotEmpty)
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: notes.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.grey, width: 0.4),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                title: Text(notes[index].name),
                                subtitle: Text(notes[index].descr),
                                trailing: Checkbox(
                                  onChanged: null,
                                  checkColor: Colors.green,
                                  value: notes[index].ready,
                                ),
                              );
                            },
                          ),
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

