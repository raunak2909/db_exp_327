import 'package:db_exp_327/db_helper.dart';
import 'package:db_exp_327/note_model.dart';
import 'package:flutter/foundation.dart';

class DBProvider extends ChangeNotifier{
  DbHelper dbHelper = DbHelper.getInstance();

  ///data
  List<NoteModel> _mNotes = [];

  void addNote({required NoteModel note}) async{
    bool check = await dbHelper.addNote(newNote: note);

    if(check){
      _mNotes = await dbHelper.fetchAllNote();
      notifyListeners();
    }
  }

  List<NoteModel> getAllNotes() => _mNotes;

  void getInitialNotes() async{
    _mNotes = await dbHelper.fetchAllNote();
    notifyListeners();
  }


}