import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/blocs.dart';

enum ExtraAction { toggle, clearComplete }

class ExtraActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoLoadSuccess) {
          bool allCompleted = state.todos.every((todo) => todo.completed);
          return PopupMenuButton<ExtraAction>(
              onSelected: (action) {
                if (action == ExtraAction.toggle) {
                  BlocProvider.of<TodoBloc>(context).add(Toggle());
                  print('toggled');
                }

                if (action == ExtraAction.clearComplete) {
                  BlocProvider.of<TodoBloc>(context).add(ClearCompleted());
                }
              },
              itemBuilder: (context) => <PopupMenuItem<ExtraAction>>[
                    PopupMenuItem<ExtraAction>(
                        value: ExtraAction.toggle,
                        child: Text(allCompleted
                            ? 'Mark All Incomplete'
                            : 'Mark All Complete')),
                    PopupMenuItem<ExtraAction>(
                        value: ExtraAction.clearComplete,
                        child: Text('Clear Completed')),
                  ]);
        }
        return Container();
      },
    );
  }
}
