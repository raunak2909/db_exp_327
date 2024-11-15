import 'package:db_exp_327/db_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

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
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(mData[index]["n_title"]),
                  subtitle: Text(mData[index]["n_desc"]),
                  trailing: SizedBox(
                    width: 120,
                    child: Row(
                      children: [
                        IconButton(onPressed: () async{
                         bool check = await dbHelper.updateNote(title: "Update Note", desc: "Updated Desc", id: mData[index]["n_id"]);
                         if(check){
                           getNotes();
                         }
                        }, icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
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
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(40))),
              backgroundColor: Colors.orange,
              /*isDismissible: false,*/
              enableDrag: false,
              context: context,
              builder: (_) {
                return Container(
                  padding: EdgeInsets.all(11),
                  height: 500,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(40))),
                  child: Column(
                    children: [
                      Text(
                        'Add Note',
                        style: TextStyle(fontSize: 21),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          label: Text('Title*'),
                          hintText: "Enter your title here..",
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11)),
                        ),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      TextField(
                        controller: descController,
                        minLines: 4,
                        maxLines: 4,
                        decoration: InputDecoration(
                          label: Text('Desc*'),
                          hintText: "Enter your description here..",
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11)),
                        ),
                      ),
                      SizedBox(
                        height: 21,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                              onPressed: () async{
                                if (titleController.text.isNotEmpty &&
                                    descController.text.isNotEmpty) {
                                  bool check = await dbHelper.addNote(
                                      title: titleController.text.toString(),
                                      desc: descController.text.toString());

                                  if(check){
                                    Navigator.pop(context);
                                    getNotes();
                                  } else {
                                    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: Note not added!!")));
                                  }
                                } else {
                                  //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: Please fill all the required blanks!!")));
                                }


                              },
                              child: Text('Add')),
                          SizedBox(
                            width: 11,
                          ),
                          OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel')),
                        ],
                      ),
                    ],
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
