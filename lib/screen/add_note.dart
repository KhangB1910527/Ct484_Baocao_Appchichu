import 'dart:math';

import 'package:appghichu/db/database_provider.dart';
import 'package:appghichu/model/note_model.dart';
import 'package:appghichu/thems/thems.dart';
import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  int color_id = Random().nextInt(AppStyle.cardsColor.length);
  //Tao ham addnode

  String title;
  String body;
  DateTime date;
  //Tao xu ly dau vao
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  addNote(NoteModel note) {
    DatabaseProvider.db.addNewNote(note);
    print("Đã thêm thành công");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 107, 102, 102),
        title: Text("Thêm một ghi chú"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Tên ghi chú",
              ),
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: TextField(
                controller: bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "nhập ghi chú của bạn",
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            title = titleController.text;
            body = bodyController.text;
            date = DateTime.now();
          });
          NoteModel note =
              NoteModel(title: title, body: body, creation_date: date);
          addNote(note);
          //nhan luu, ve trang chu
          Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
        },
        label: Text("Lưu"),
        backgroundColor: Color.fromARGB(255, 161, 153, 129),
        icon: Icon(Icons.save),
      ),
    );
  }
}
