import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_dio_hive_flutter/categories_list.dart';
import 'package:todo_bloc_dio_hive_flutter/screens/filter_screen.dart';
import 'package:todo_bloc_dio_hive_flutter/notes_bloc/note_bloc.dart';
import 'package:todo_bloc_dio_hive_flutter/popup_menus/add_note.dart';
import 'package:todo_bloc_dio_hive_flutter/popup_menus/change_category_menu.dart';

import 'weather_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    //following for note-list
    final notes = context.select((NoteBloc nbloc) => nbloc.state.notes);

    return Scaffold(
      appBar: AppBar(
        //Go to weather-page
        leading: IconButton(icon: const Icon(Icons.cloud_outlined),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(
                  builder: (_) =>
                      BlocProvider.value(
                          value: NoteBloc(),
                          child: const WeatherScreen()),
                ));
          },),
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: const Text("ToDosApp"),
      ),
      body: Center(
        child: Column(
          children: [
            //NOTES LISTVIEW here
            Container(
              constraints: BoxConstraints(maxHeight: 620), //for ListView-render-exception
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
                              onTap: () {changeReadyState(context, notes[index].category,notes[index].id);},
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black, width: 0.5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              //DElETE button
                              leading: IconButton(
                                onPressed: () {
                                  //remove
                                  BlocProvider.of<NoteBloc>(context).add(NoteRemoveEvent(notes[index].id));
                                  },
                                icon: Icon(Icons.delete),
                              ),
                              title: Text(notes[index].name),
                              subtitle: Text(notes[index].descr),
                              //Ready CHECKBOX
                              trailing: ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 100),
                                child: Checkbox(
                                  checkColor: Colors.green,
                                  value: notes[index].ready,
                                  onChanged: (bool? value)  {
                                    //readychange
                                    BlocProvider.of<NoteBloc>(context).add(NoteReadyChangeEvent(notes[index].id, value!));
                                    },
                                )//Text(notes[index].category),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Go Filter-menu
            ElevatedButton(
                child: Container( height: 60,
                    child: Center(child: const Text('Filter:', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),))),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                        builder: (_) =>
                            BlocProvider.value(
                                value: NoteBloc(),
                                child: const FilterScreen()),
                      ));
                }),
            const Spacer(),
            //AddNoteMenu
            FloatingActionButton(
              onPressed: () {
                addNoteMenu(context);
              },
              tooltip: 'Add new element',
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

