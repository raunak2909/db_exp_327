import 'package:db_exp_327/cubit/db_cubit.dart';
import 'package:db_exp_327/db_helper.dart';
import 'package:db_exp_327/db_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'note_model.dart';

class AddNotePage extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  DbHelper dbHelper = DbHelper.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Container(
        padding: EdgeInsets.all(11),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40))),
        child: Column(
          children: [
            SizedBox(
              height: 11,
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                label: Text('Title*'),
                hintText: "Enter your title here..",
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
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
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
              ),
            ),
            SizedBox(
              height: 11,
            ),
            /*OutlinedButton(onPressed: () async{

              DateTime? selectedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(9999));

              print(selectedDate!.millisecondsSinceEpoch.toString());
              dueDate = selectedDate.millisecondsSinceEpoch.toString();


            }, child: Text("Choose Date")),*/
            SizedBox(
              height: 21,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                    onPressed: () async {
                      if (titleController.text.isNotEmpty &&
                          descController.text.isNotEmpty) {
                        bool check = false;

                        /*if (isUpdate) {
                          check = await dbHelper.updateNote(
                              title: titleController.text,
                              desc: descController.text,
                              id: nId);
                        } else {*/

                        context.read<DBCubit>().addData(NoteModel(
                            title: titleController.text,
                            desc: descController.text,
                            createdAt: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString()));

                        /*context.read<DBProvider>().addNote(
                            note: NoteModel(
                                title: titleController.text,
                                desc: descController.text,
                                createdAt: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString()));*/

                        Navigator.pop(context);

                        /* check = await dbHelper.addNote();

                        //}

                        if(check){
                          Navigator.pop(context);
                          //getNotes();
                        }*/
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
      ),
    );
  }
}
