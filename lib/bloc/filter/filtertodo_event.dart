part of 'filtertodo_bloc.dart';

abstract class FiltertodoEvent extends Equatable {
  const FiltertodoEvent();
  @override
  List<Object> get props => [];
}

class FilterUpdated extends FiltertodoEvent {
  final VisibilityFilter visibility;

  const FilterUpdated(this.visibility);

  @override
  String toString() {
    return 'filter Updated :$visibility';
  }

  @override
  List<Object> get props => [visibility];
}

class TodosUpdated extends FiltertodoEvent {
  final List<Todo> todos;

  const TodosUpdated(this.todos);

  @override
  List<Object> get props => [todos];
  @override
  String toString() {
    return 'Todo Updated: ';
  }
}
