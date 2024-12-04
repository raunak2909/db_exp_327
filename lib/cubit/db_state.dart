import 'package:db_exp_327/note_model.dart';

abstract class DBState {}

class DbInitialState extends DBState{}
class DbLoadingState extends DBState{}
class DbLoadedState extends DBState{
  List<NoteModel> notes;
  DbLoadedState({required this.notes});
}
class DbErrorState extends DBState{
  String errorMsg;
  DbErrorState({required this.errorMsg});
}