import 'package:db_exp_327/note_model.dart';

abstract class NoteEvent{}

class AddNoteEvent extends NoteEvent{
  NoteModel newNote;
  AddNoteEvent({required this.newNote});
}
class FetchInitialNoteEvent extends NoteEvent{}
class UpdateNoteEvent extends NoteEvent{
  NoteModel updatedNote;
  UpdateNoteEvent({required this.updatedNote});
}
class DeleteNoteEvent extends NoteEvent{
  int id;
  DeleteNoteEvent({required this.id});
}