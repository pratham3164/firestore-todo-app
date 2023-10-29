import 'package:todo/entites/todo_entity.dart';

class Todo {


  final String id;
  final String task;
  final String note;
  final bool completed;
  final String message;

  Todo({this.id, this.task, this.note, this.completed});

  Todo copyWith({String id, String task, String note, bool completed}) {
    return Todo(
      id: id ?? this.id,
      task: task ?? this.task,
      note: note ?? this.note,
      completed: completed ?? this.completed,
    );
  }

  @override
  String toString() {
    return 'id:$id , task:$task ,note:$note ,completed:$completed';
  }

  @override
  int get hashCode =>
      completed.hashCode ^ task.hashCode ^ note.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo &&
          runtimeType == other.runtimeType &&
          completed == other.completed &&
          task == other.task &&
          note == other.note &&
          id == other.id;
  // @override
  // int get hashCode => super.hashCode;

  TodoEntity toEntity() {
    return TodoEntity(
      id: id,
      task: task,
      note: note,
      completed: completed,
    );
  }

  static Todo fromEntity(TodoEntity todoEntity) {
    return Todo(
        completed: todoEntity.completed ?? false,
        id: todoEntity.id,
        task: todoEntity.task,
        note: todoEntity.note);
  }
}
