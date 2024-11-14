import 'package:db_exp_327/db_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DbHelper dbHelper = DbHelper.getInstance();
  List<Map<String, dynamic>> mData = [];

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  void getNotes() async {
    mData = await dbHelper.fetchAllNote();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: mData.isNotEmpty
          ? ListView.builder(
        itemCount: mData.length,
          itemBuilder: (_, index){
            return ListTile(
              title: Text(mData[index]["n_title"]),
              subtitle: Text(mData[index]["n_desc"]),
              trailing: SizedBox(
                width: 120,
                child: Row(
                  children: [
                    IconButton(onPressed: (){

                    }, icon: Icon(Icons.update)),
                    IconButton(onPressed: (){

                    }, icon: Icon(Icons.delete, color: Colors.red,)),
                  ],
                ),
              ),
            );
      })
          : Center(
              child: Text('No notes yet!!'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool check = await dbHelper.addNote(
              title: "My Note",
              desc: "Today was a Fantastic day as every day.");

          if (check) {
            print("Note added successfully!!");
            getNotes();
          } else {
            print("Failed to add note");
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
