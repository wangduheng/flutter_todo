import 'package:flutter/material.dart';
import 'package:flutter_todos/pojo/pojo.dart';
import 'package:todos_app_core/todos_app_core.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckboxChanged;

  TodoItem(
      {Key key,
      @required this.todo,
      @required this.onDismissed,
      @required this.onTap,
      @required this.onCheckboxChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: ArchSampleKeys.todoItem(todo.id),
        onDismissed: onDismissed,
        child: ListTile(
          onTap: onTap,
          subtitle: todo.note.isNotEmpty
              ? Text(
                  todo.note,
                  key: ArchSampleKeys.todoItemNote(todo.id),
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subhead,
                  maxLines: 1,
                )
              : null,
          title: Hero(
              tag: '${todo.id}__heroTag',
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  todo.task,
                  key: ArchSampleKeys.todoItemTask(todo.id),
                  style: Theme.of(context).textTheme.title,
                ),
              )),
          leading: Checkbox(
            value: todo.complete,
            onChanged: onCheckboxChanged,
            key: ArchSampleKeys.todoItemCheckbox(todo.id),
          ),
        ));
  }
}
