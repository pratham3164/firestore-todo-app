import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final bool completed;
  final String id;
  final String note;
  final String task;

  const TodoEntity({this.completed, this.id, this.note, this.task});

  @override
  List<Object> get props => [completed, id, note, task];

  Map<String, Object> toJSON() {
    return {
      "id": id,
      "task": task,
      "note": note,
      "completed": completed,
    };
  }

  static TodoEntity fromJSON(Map<String, Object> todo) {
    return TodoEntity(
      id: todo['id'] as String,
      task: todo['task'] as String,
      note: todo['note'] as String,
      completed: todo['completed'] as bool,
    );
  }

  static TodoEntity fromDocument(DocumentSnapshot snap) {
    return TodoEntity(
      id: snap.documentID,
      task: snap.data['task'],
      note: snap.data['note'],
      completed: snap.data['completed'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "task": task,
      "note": note,
      "completed": completed,
    };
  }
}
