import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/repostories/todo/todo_repo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _todoRepository;
  StreamSubscription _todoSubscription;
  TodoBloc(TodoRepository todoRepository)
      : assert(todoRepository != null),
        _todoRepository = todoRepository,
        super(TodoLoadInProgress());

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    if (event is TodoLoaded) {
      yield* _mapTodoLoadSuccessToState();
    } else if (event is TodoAdded) {
      yield* _mapTodoAddedToState(event);
    } else if (event is TodoUpdate) {
      yield* _mapTodoUpdateToState(event);
    } else if (event is TodoDelete) {
      yield* _mapTodoDeleteToState(event);
    } else if (event is Toggle) {
      yield* _mapToggleToState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    } else if (event is TodoUpdated) {
      yield* _mapTodoUpdatedToState(event);
    }
  }

  Stream<TodoState> _mapTodoLoadSuccessToState() async* {
    _todoSubscription?.cancel();
    _todoSubscription = _todoRepository.todo().listen(
          (todo) => add(TodoUpdated(todo)),
        );
  }

  Stream<TodoState> _mapTodoAddedToState(TodoAdded event) async* {
    _todoRepository.addTodo(event.todo);
  }

  Stream<TodoState> _mapTodoUpdateToState(TodoUpdate event) async* {
    _todoRepository.updateTodo(event.todo);
  }

  Stream<TodoState> _mapTodoDeleteToState(TodoDelete event) async* {
    _todoRepository.deleteTodo(event.todo);
  }

  Stream<TodoState> _mapToggleToState() async* {
    final currentState = state;
    if (currentState is TodoLoadSuccess) {
      final allComplete = currentState.todos.every((todo) => todo.completed);
      print(allComplete);
      final List<Todo> updateTodo = currentState.todos
          .map((todo) => todo.copyWith(completed: !allComplete))
          .toList();
      updateTodo
          .forEach((updatedTodo) => _todoRepository.updateTodo(updatedTodo));
    }
  }

  Stream<TodoState> _mapClearCompletedToState() async* {
    final currentState = state;
    if (currentState is TodoLoadSuccess) {
      final List<Todo> completed =
          currentState.todos.where((todo) => todo.completed).toList();
      completed.forEach((todo) => _todoRepository.deleteTodo(todo));
    }
  }

  Stream<TodoState> _mapTodoUpdatedToState(TodoUpdated event) async* {
    yield TodoLoadSuccess(event.todo);
  }

  @override
  Future<void> close() {
    _todoSubscription?.cancel();
    return super.close();
  }
}
