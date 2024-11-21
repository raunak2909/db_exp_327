import 'package:db_exp_327/db_helper.dart';

class NoteModel {
  int? id;
  String title;
  String desc;
  String createdAt;

  NoteModel({
      this.id,
      required this.title,
      required this.desc,
      required this.createdAt});

  factory NoteModel.fromMap(Map<String, dynamic> map){
    return NoteModel(
        id: map[DbHelper.NOTE_COLUMN_ID],
        title: map[DbHelper.NOTE_COLUMN_TITLE],
        desc: map[DbHelper.NOTE_COLUMN_DESC],
        createdAt: map[DbHelper.NOTE_COLUMN_CREATED_AT]);
  }


  Map<String ,dynamic> toMap() => {
      DbHelper.NOTE_COLUMN_TITLE : title,
      DbHelper.NOTE_COLUMN_DESC : desc,
      DbHelper.NOTE_COLUMN_CREATED_AT : createdAt,
    };

}
