import 'package:db_exp_327/note_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{

  /// step 1 private constructor
  DbHelper._();

  /// step 2 creating a static global instance to this class
  //static final DbHelper instance = DbHelper._();

  static DbHelper getInstance() => DbHelper._();

  Database? mDB;

  static final String TABLE_NOTE = "note";
  static final String NOTE_COLUMN_ID = "n_id";
  static final String NOTE_COLUMN_TITLE = "n_title";
  static final String NOTE_COLUMN_DESC = "n_desc";
  static final String NOTE_COLUMN_CREATED_AT = "n_created_at";
  static final String NOTE_COLUMN_COMPLETE_AT = "n_complete_at";

  ///open DB
  Future<Database> initDB() async{

    mDB = mDB ?? await openDB();
    print("db opened!!");
    return mDB!;

    /*if(mDB!=null){
      return mDB!;
    } else {
      mDB = await openDB();
      return mDB!;
    }*/

  }

  Future<Database> openDB() async{
    /// data/data/com.skvksv.dkvmd/databases/noteDb.db
    var dirPath = await getApplicationDocumentsDirectory();
    var dbPath = join(dirPath.path, "noteDB.db");

    return openDatabase(dbPath, version: 1, onCreate: (db, version){

      print("db created!!");
      ///create tables
      db.execute("create table $TABLE_NOTE ( $NOTE_COLUMN_ID integer primary key autoincrement, $NOTE_COLUMN_TITLE text, $NOTE_COLUMN_DESC text, $NOTE_COLUMN_CREATED_AT text,)");

    });

  }

  ///insert
  Future<bool> addNote(NoteModel newNote) async{

    Database db = await initDB();

    int rowsEffected = await db.insert(TABLE_NOTE,
        newNote.toMap());

    return rowsEffected>0;

  }

  ///select
  Future<List<NoteModel>> fetchAllNote() async{

    Database db = await initDB();
    List<NoteModel> mNotes = [];

    List<Map<String, dynamic>> allNotes = await db.query(TABLE_NOTE);/// select * from note

    for(Map<String, dynamic> eachData in allNotes){
      NoteModel eachNote = NoteModel.fromMap(eachData);
      mNotes.add(eachNote);
    }


    return mNotes;
  }


  ///update
  Future<bool> updateNote({required String title, required String desc, required int id}) async{

    Database db = await initDB();

    int rowsEffected = await db.update(TABLE_NOTE, {
      NOTE_COLUMN_TITLE : title,
      NOTE_COLUMN_DESC : desc,
    }, where: "$NOTE_COLUMN_ID = ?", whereArgs: ['$id']);

    return rowsEffected>0;

  }
  ///delete
  Future<bool> deleteNote({required int id}) async{

    Database db = await initDB();

    int rowsEffected = await db.delete(TABLE_NOTE, where: "$NOTE_COLUMN_ID = ?", whereArgs: ['$id']);

    return rowsEffected>0;
  }

}