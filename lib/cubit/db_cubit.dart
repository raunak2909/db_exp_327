import 'package:db_exp_327/cubit/db_state.dart';
import 'package:db_exp_327/db_helper.dart';
import 'package:db_exp_327/note_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DBCubit extends Cubit<DBState>{
  DbHelper dbHelper;
  DBCubit({required this.dbHelper}) : super(DbInitialState());

  ///events
  void addData(NoteModel newNote) async{

    emit(DbLoadingState());

    bool check = await dbHelper.addNote(newNote);
    if(check){
      List<NoteModel> allNotes = await dbHelper.fetchAllNote();
      emit(DbLoadedState(notes: allNotes));
    } else {
      emit(DbErrorState(errorMsg: "Note not added!!"));
    }

  }

  void getInitialNotes() async{

    emit(DbLoadingState());

    List<NoteModel> mNotes = await dbHelper.fetchAllNote();
    emit(DbLoadedState(notes: mNotes));
  }

}