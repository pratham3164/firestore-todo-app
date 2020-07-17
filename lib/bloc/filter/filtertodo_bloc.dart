import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:todo/bloc/todo/todo_bloc.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/model/visibility_filter.dart';

part 'filtertodo_event.dart';
part 'filtertodo_state.dart';

class FiltertodoBloc extends Bloc<FiltertodoEvent, FiltertodoState> {
  final TodoBloc todoBloc;

  StreamSubscription _todoSubscription;
  FiltertodoBloc({@required this.todoBloc})
      : super(todoBloc.state is TodoLoadSuccess
            ? FilterTodoLoadSuccess(
                (todoBloc.state as TodoLoadSuccess).todos, VisibilityFilter.all)
            : FiltertodoLoading()) {
    _todoSubscription = todoBloc.listen((state) {
      if (state is TodoLoadSuccess) {
        add(TodosUpdated((todoBloc.state as TodoLoadSuccess).todos));
      }
    });
  }

  @override
  Stream<FiltertodoState> mapEventToState(
    FiltertodoEvent event,
  ) async* {
    if (event is FilterUpdated) {
      yield* _mapFilterUpdatedToState(event);
    } else if (event is TodosUpdated) {
      yield* _mapTodoUpdatedToState(event);
    }
  }

  Stream<FiltertodoState> _mapFilterUpdatedToState(FilterUpdated event) async* {
    yield FilterTodoLoadSuccess(
        _mapTodosToFilter(
            (todoBloc.state as TodoLoadSuccess).todos, event.visibility),
        event.visibility);
  }

  Stream<FiltertodoState> _mapTodoUpdatedToState(TodosUpdated event) async* {
    final visibilityFilter = state is FilterTodoLoadSuccess
        ? (state as FilterTodoLoadSuccess).visibility
        : VisibilityFilter.all;
    print('-------------------TODOUPdate------------------------');
    yield FilterTodoLoadSuccess(
        _mapTodosToFilter(
          (todoBloc.state as TodoLoadSuccess).todos,
          visibilityFilter,
        ),
        visibilityFilter);
  }

  List<Todo> _mapTodosToFilter(List<Todo> todos, VisibilityFilter filter) {
    return todos.where((todo) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !todo.completed;
      } else {
        return todo.completed;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    _todoSubscription?.cancel();
    return super.close();
  }
}
