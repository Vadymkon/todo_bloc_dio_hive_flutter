import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../notes_bloc/note_bloc.dart';

Future<void> addNoteMenu(BuildContext context) async {
  TextEditingController nameCont = TextEditingController();
  TextEditingController descrCont = TextEditingController();

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add new note'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              //menu adding
              Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: 'Name',
                    ),
                    controller: nameCont,
                  ),
                  Container(height: 10,),
                  TextField(
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: 'Description',
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    controller: descrCont,
                  ),

                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Add'),
            onPressed: () {
              BlocProvider.of<NoteBloc>(context).add(
                  NoteAddEvent( nameCont.text, descrCont.text));
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}