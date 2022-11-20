import 'dart:math';

import 'package:appghichu/db/database_provider.dart';
import 'package:appghichu/model/note_model.dart';
import 'package:appghichu/thems/thems.dart';
import 'package:flutter/material.dart';

class ShowNote extends StatefulWidget {
  const ShowNote({Key key}) : super(key: key);

  @override
  State<ShowNote> createState() => _ShowNoteState();
}

class _ShowNoteState extends State<ShowNote> {
  int color_id = Random().nextInt(AppStyle.cardsColor.length);
  @override
  Widget build(BuildContext context) {
    final NoteModel note =
        ModalRoute.of(context).settings.arguments as NoteModel;
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        title: Text("Ghi chú"),
        backgroundColor: Color.fromARGB(255, 107, 102, 102),
        //delete

        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              DatabaseProvider.db.deleteNote(note.id);
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Text(
              note.title,
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              note.body,
              style: TextStyle(fontSize: 18.0),
            )
          ],
        ),
      ),
    );
  }
}
