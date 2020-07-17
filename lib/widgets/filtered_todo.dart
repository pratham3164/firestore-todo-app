import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/blocs.dart';
import 'package:todo/bloc/filter/filtertodo_bloc.dart';
import 'package:todo/screens/details_screen.dart';
import 'package:todo/widgets/snackBar.dart';
import 'package:todo/widgets/todo_item.dart';

class FilteredTodo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltertodoBloc, FiltertodoState>(
        builder: (context, state) {
      if (state is FiltertodoLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is FilterTodoLoadSuccess) {
        final todos = state.filteredTodos;
        return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoItem(
                  todo: todo,
                  onTap: () async {
                    final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => DetailsScreen(id: todo.id)));
                    if (result != null) {
                      Scaffold.of(context).showSnackBar(DeleteTodoSnackBar(
                          todo: todo,
                          onUndo: () => BlocProvider.of<TodoBloc>(context)
                              .add(TodoAdded(todo))));
                    }
                  },
                  onChanged: (value) => BlocProvider.of<TodoBloc>(context)
                      .add(TodoUpdate(todo.copyWith(completed: value))),
                  onDismissed: (direction) {
                    BlocProvider.of<TodoBloc>(context).add(TodoDelete(todo));
                    Scaffold.of(context).showSnackBar(DeleteTodoSnackBar(
                        todo: todo,
                        onUndo: () => BlocProvider.of<TodoBloc>(context)
                            .add(TodoAdded(todo))));
                  });
            });
      }
      return Container();
    });
  }
}
