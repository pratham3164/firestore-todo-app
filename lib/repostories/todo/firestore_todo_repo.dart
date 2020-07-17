import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/entites/todo_entity.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/repostories/todo/todo_repo.dart';

class FirestoreTodoRepository implements TodoRepository {
  final firestore = Firestore.instance.collection('todo');
  @override
  Future<void> addTodo(Todo todo) {
    return firestore.add(todo.toEntity().toDocument());
  }

  @override
  Future<void> deleteTodo(Todo todo) {
    return firestore.document(todo.id).delete();
  }

  @override
  Stream<List<Todo>> todo() {
    return firestore.snapshots().map((snapshot) => snapshot.documents
        .map((doc) => Todo.fromEntity(TodoEntity.fromDocument(doc)))
        .toList());
  }

  @override
  Future<void> updateTodo(Todo update) {
    return firestore
        .document(update.id)
        .updateData(update.toEntity().toDocument());
  }
}
