import 'package:flutter/material.dart';
import 'package:flutter_todos/pojo/pojo.dart';
import 'package:todos_app_core/todos_app_core.dart';

class DeleteTodoSnackBar extends SnackBar {
  final ArchSampleLocalizations localizations;

  DeleteTodoSnackBar(
      {Key key,
      @required Todo todo,
      @required VoidCallback onUndo,
      this.localizations})
      : super(
            key: key,
            duration: Duration(seconds: 2),
            action:
                SnackBarAction(label: localizations.undo, onPressed: onUndo),
            content: Text(
              localizations.todoDeleted(todo.task),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ));
}
