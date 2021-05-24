import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class EditNote extends StatefulWidget {
  DocumentSnapshot docToEdit;
  EditNote({this.docToEdit});
  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  @override
  void initState() {
  title= TextEditingController(text: widget.docToEdit.data()['title']);
  content= TextEditingController(text: widget.docToEdit.data()['content']);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        actions: [

          FlatButton(
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              widget.docToEdit.reference.delete().whenComplete(() => Navigator.pop(context));
            },
          ),
          FlatButton(
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              widget.docToEdit.reference.update({
                'title':title.text,
                'content':content.text,
              }).whenComplete(() => Navigator.pop(context));
            },
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.deepPurple)),
              child: TextField(

                controller: title,
                decoration: InputDecoration(
                    border:InputBorder.none,
                    hintText: 'Title'),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.deepPurple)),
                child: TextField(

                  controller: content,
                  expands: true,
                  maxLines: null,
                  decoration: InputDecoration(
                      border:InputBorder.none,
                      hintText: 'Content'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
