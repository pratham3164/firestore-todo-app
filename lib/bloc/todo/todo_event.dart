part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TodoLoaded extends TodoEvent {}

class TodoAdded extends TodoEvent {
  final Todo todo;

  const TodoAdded(this.todo);
  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'Todo Added :$todo';
}

class TodoDelete extends TodoEvent {
  final Todo todo;

  const TodoDelete(this.todo);
  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'Todo deleted :$todo';
}

class TodoUpdate extends TodoEvent {
  final Todo todo;

  const TodoUpdate(this.todo);
  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'Todo Update :$todo';
}

class TodoUpdated extends TodoEvent {
  final List<Todo> todo;

  const TodoUpdated(this.todo);
  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'Todo Updated :$todo';
}

class ClearCompleted extends TodoEvent {}

class Toggle extends TodoEvent {}
