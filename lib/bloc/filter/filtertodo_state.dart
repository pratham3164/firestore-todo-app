part of 'filtertodo_bloc.dart';

abstract class FiltertodoState extends Equatable {
  const FiltertodoState();
  @override
  List<Object> get props => [];
}

class FiltertodoLoading extends FiltertodoState {}

class FilterTodoLoadSuccess extends FiltertodoState {
  final List<Todo> filteredTodos;
  final VisibilityFilter visibility;

  FilterTodoLoadSuccess(this.filteredTodos, this.visibility);
  @override
  String toString() {
    return 'Filter Load Sucsess : Visibility:$visibility, todos:$filteredTodos';
  }

  @override
  List<Object> get props => [filteredTodos, visibility];
}
