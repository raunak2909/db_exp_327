import 'package:db_exp_327/note_model.dart';

abstract class NoteState{}

class NoteInitialState extends NoteState{}

class NoteLoadingState extends NoteState{}

class NoteLoadedState extends NoteState{
  List<NoteModel> mNotes;
  NoteLoadedState({required this.mNotes});
}

class NoteErrorState extends NoteState{
  String errorMsg;
  NoteErrorState({required this.errorMsg});
}