import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:todo/bloc/todo/todo_bloc.dart';
import 'package:todo/model/todo.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final TodoBloc todoBloc;
  StreamSubscription _streamSubscription;
  StatsBloc({@required this.todoBloc}) : super(StatsLoadInProgress()) {
    _streamSubscription = todoBloc.listen((state) {
      if (state is TodoLoadSuccess) {
        add(StatsUpdated((state).todos));
      }
    });
  }

  @override
  Stream<StatsState> mapEventToState(
    StatsEvent event,
  ) async* {
    if (event is StatsUpdated) {
      final numActive =
          event.todos.where((todo) => !todo.completed).toList().length;
      final numCompleted =
          event.todos.where((todo) => todo.completed).toList().length;
      yield StatsLoadSuccess(numActive, numCompleted);
    }
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
