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
      db.execute("create table note ( n_id integer primary key autoincrement, n_title text, n_desc text)");

    });


  }

  void addNote({required String title, required String desc}) async{

    Database db = await initDB();

    db.insert("note", {

    });

  }

}