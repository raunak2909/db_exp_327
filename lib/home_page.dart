import 'package:db_exp_327/add_note_page.dart';
import 'package:db_exp_327/bloc/note_bloc.dart';
import 'package:db_exp_327/bloc/note_state.dart';
import 'package:db_exp_327/cubit/db_cubit.dart';
import 'package:db_exp_327/db_helper.dart';
import 'package:db_exp_327/db_provider.dart';
import 'package:db_exp_327/note_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cubit/db_state.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  DbHelper dbHelper = DbHelper.getInstance();
  List<NoteModel> mData = [];
  bool isChecked = false;
  String dueDate = "";

  @override
  void initState() {
    super.initState();
    //context.read<DBProvider>().getInitialNotes();
    //context.read<DBCubit>().getInitialNotes();
  }


  @override
  Widget build(BuildContext context) {

   // mData = context.watch<DBCubit>().state.mData;

    //mData = context.watch<DBProvider>().getAllNotes();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: updateDataAccToState(context.watch<NoteBloc>().state),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotePage(),));

          /*titleController.clear();
          descController.clear();
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(40))),
              backgroundColor: Colors.orange,
              *//*isDismissible: false,*//*
              enableDrag: false,
              context: context,
              builder: (_) {
                return getBottomSheetUI();
              });*/
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget updateDataAccToState(NoteState state) {
    if(state is NoteLoadingState){
      return Center(child: CircularProgressIndicator(),);
    } else if (state is NoteErrorState){
      return Center(child: Row(
        children: [
          Icon(Icons.error, color:  Colors.red,),
          Text("${state.errorMsg}"),
        ],
      ),);
    } else if(state is NoteLoadedState){
      mData = state.mNotes;
      return mData.isNotEmpty
          ? ListView.builder(
          itemCount: mData.length,
          itemBuilder: (_, index) {
            return ListTile(
              leading: Checkbox(value: isChecked, onChanged: (value){
                isChecked = value!;
                setState(() {

                });
              }),
              title: Text(mData[index].title),
              subtitle: Text(mData[index].desc),
              trailing: SizedBox(
                width: 150,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () async {

                          /*titleController.text = mData[index].title;
                              descController.text = mData[index].desc;

                              showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(40))),
                                  backgroundColor: Colors.orange,
                                  *//*isDismissible: false,*//*
                                  enableDrag: false,
                                  context: context,
                                  builder: (_) {
                                    return getBottomSheetUI(isUpdate: true, nId: mData[index].id!);
                                  });*/
                        },
                        icon: Icon(Icons.edit)),
                    IconButton(
                        onPressed: () async{
                          /*bool check = await dbHelper.deleteNote(id: mData[index].id!);
                              if(check){
                                getNotes();
                              }*/
                        },
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
      );
    } else {
      return Container();
    }
  }

  /*Widget getBottomSheetUI({bool isUpdate = false, int nId = 0}) {
    return Container(
      padding: EdgeInsets.all(11),
      height: 500,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40))),
      child: Column(
        children: [
          Text(
            isUpdate ? 'Update Note' : 'Add Note',
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
          OutlinedButton(onPressed: () async{

            DateTime? selectedDate = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime(9999));

            print(selectedDate!.millisecondsSinceEpoch.toString());
            dueDate = selectedDate.millisecondsSinceEpoch.toString();


          }, child: Text("Choose Date")),
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

                      if (isUpdate) {
                        check = await dbHelper.updateNote(
                            title: titleController.text,
                            desc: descController.text,
                            id: nId);
                      } else {
                        check = await dbHelper.addNote(NoteModel(
                            title: titleController.text,
                            desc: descController.text,
                            createdAt: DateTime.now().millisecondsSinceEpoch.toString()));

                      }

                      if(check){
                        Navigator.pop(context);
                        getNotes();
                      }
                    }
                  },
                  child: Text(isUpdate ? 'Update' : 'Add')),
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
  }*/
}
