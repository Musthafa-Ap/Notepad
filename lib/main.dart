import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/AddNote.dart';
import 'package:flutter_app/EditNote.dart';



void main()  async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ref = FirebaseFirestore.instance.collection('notes');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Notes App'),backgroundColor: Colors.deepPurple,),

      floatingActionButton: FloatingActionButton(backgroundColor: Colors.deepPurple,child: Icon(Icons.add,),
        onPressed: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNote()));
        }
        ,),
      body:StreamBuilder(
        stream: ref.snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
          return GridView.builder(
            physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount:snapshot.hasData?snapshot.data.docs.length:0,
              itemBuilder: (_,index){
            return GestureDetector(
              onLongPress: (){
                showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      title: Text("Delete"),
                      content: Text("Do you want to delete this note?"),
                      actions: [
                        FlatButton(
                          child: Text("No",style: TextStyle(color: Colors.black),),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                         color: Colors.white,
                        ),
                        FlatButton(
                          child: Text("Yes"),
                          onPressed: (){
                            snapshot.data.docs[index].reference.delete();
                            Navigator.pop(context);
                          },
                          color: Colors.deepPurple,
                        )
                      ],
                    );
                  }

                );
              },
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>EditNote(docToEdit: snapshot.data.docs[index],)));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                  border: Border.all(color: Colors.deepPurple[200])
                ),
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height/4.2,

                child: Column(
                  children: [
                    Text(snapshot.data.docs[index].data()['title'],style: TextStyle(fontSize: 20,color: Colors.deepPurple),),
                    Divider(thickness: .4,color: Colors.deepPurple,),
                    SizedBox(height: 10,),
                    Text(snapshot.data.docs[index].data()['content'],style: TextStyle(fontSize: 15),)
                  ],
                ),
              ),
            );
              }
          );
        }
      )
    );
  }
}


