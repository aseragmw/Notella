

import 'constants.dart';

class CloudNote {
  String id;
  String userId;
  String text;
  List<TodoItem> todos;

  CloudNote(this.id, this.userId, this.text, this.todos);


}



class TodoItem {
  String id;
  String noteId;
  String text;

  TodoItem(this.id, this.noteId, this.text);
}
