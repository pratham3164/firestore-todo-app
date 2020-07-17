import 'package:flutter/material.dart';
import 'package:todo/model/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onChanged;
  final DismissDirectionCallback onDismissed;

  const TodoItem({
    Key key,
    @required this.todo,
    @required this.onTap,
    @required this.onChanged,
    @required this.onDismissed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: ValueKey(todo.id),
        onDismissed: onDismissed,
        child: ListTile(
          onTap: onTap,
          leading: Checkbox(value: todo.completed, onChanged: onChanged),
          title: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              todo.task,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          subtitle: todo.note.isNotEmpty
              ? Text(
                  todo.note,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle1,
                )
              : null,
        ));
  }
}
