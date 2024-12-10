import 'package:db_exp_327/bloc/note_event.dart';
import 'package:db_exp_327/bloc/note_state.dart';
import 'package:db_exp_327/db_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState>{
  DbHelper dbHelper;
  NoteBloc({required this.dbHelper}) : super(NoteInitialState()){

    on<AddNoteEvent>((event, emit) async{
      emit(NoteLoadingState());

      bool check = await dbHelper.addNote(newNote: event.newNote);

      if(check){
        var allNotes = await dbHelper.fetchAllNote();
        emit(NoteLoadedState(mNotes: allNotes));
      } else {
        emit(NoteErrorState(errorMsg: "Note not added!!"));
      }

    });

    /// all events here...

  }

}