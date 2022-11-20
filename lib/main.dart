import 'dart:math';

import 'package:appghichu/db/database_provider.dart';
import 'package:appghichu/model/note_model.dart';
import 'package:appghichu/thems/display_note.dart';
import 'package:appghichu/thems/thems.dart';
import 'package:flutter/material.dart';
import 'screen/add_note.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => HomeScreen(),
        "/AddNote": (context) => AddNote(),
        "/ShowNote": (context) => ShowNote(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int color_id = Random().nextInt(AppStyle.cardsColor.length);
  getNotes() async {
    final notes = await DatabaseProvider.db.getNotes();
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Ghi chú"),
        centerTitle: true,
        backgroundColor: AppStyle.mainColor,
      ),
      body: FutureBuilder(
        future: getNotes(),
        builder: (context, AsyncSnapshot noteData) {
          switch (noteData.connectionState) {
            case ConnectionState.waiting:
              {
                return Center(child: CircularProgressIndicator());
              }
            case ConnectionState.done:
              {
                if (noteData.data == null) {
                  return Center(
                    child: Text("you don't have any notes yet"),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: noteData.data.length,
                      itemBuilder: (context, index) {
                        String title = noteData.data[index]['title'];
                        String body = noteData.data[index]['body'];
                        String creation_date =
                            noteData.data[index]['creation_date'];
                        int id = noteData.data[index]["id"];

                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, "/ShowNote",
                                  arguments: NoteModel(
                                    title: title,
                                    body: body,
                                    creation_date:
                                        DateTime.parse(creation_date),
                                    id: id,
                                  ));
                            },
                            title: Text(title),
                            subtitle: Text(body),
                          ),
                        );
                      },
                    ),
                  );
                }
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/AddNote");
        },
        child: Icon(Icons.note_add),
        backgroundColor: Color.fromARGB(255, 135, 129, 114),
      ),
    );
  }
}
