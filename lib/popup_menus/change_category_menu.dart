import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../categories_list.dart';
import '../notes_bloc/note_bloc.dart';

//Menu for changing ready state of Note
Future<void> changeReadyState(BuildContext context, String category, String id) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Changing the category'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Now category is: '),
              //make popup menu
              DropdownMenu(
                hintText: category,
                  dropdownMenuEntries: categories,
                  onSelected:
                      (value){
                  //CHANGING HERE
                    BlocProvider.of<NoteBloc>(context).add(
                        NoteCategoryChangeEvent(
                            id,value.toString()));
                    Navigator.of(context).pop();
                  }),
            ],
          ),
        ),
        actions: <Widget>[
          //Just go back button
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}