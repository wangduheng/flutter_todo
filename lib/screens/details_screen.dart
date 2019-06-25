import 'package:flutter/material.dart';
import 'package:flutter_todos/bloc/blocs.dart';
import 'package:flutter_todos/pojo/todo.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../flutter_todo_keys.dart';
import 'add_edit_screen.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = ArchSampleLocalizations.of(context);
    TodosBloc todosBloc = BlocProvider.of<TodosBloc>(context);
    return BlocBuilder(
        bloc: todosBloc,
        builder: (context, TodosState state) {
          Todo todo = (state as TodoLoaded)
              .list
              .firstWhere((value) => value.id == id, orElse: () => null);
          return Scaffold(
            appBar: AppBar(
              title: Text(localizations.todoDetails),
              actions: [
                IconButton(
                  tooltip: localizations.deleteTodo,
                  key: ArchSampleKeys.deleteTodoButton,
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    todosBloc.dispatch(DeleteTodo(todo));
                    Navigator.pop(context, todo);
                  },
                )
              ],
            ),
            body: todo == null
                ? Container(key: FlutterTodoKeys.emptyDetailsContainer)
                : Padding(
                    padding: EdgeInsets.all(8),
                    child: ListView(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Checkbox(
                                key: FlutterTodoKeys.detailsScreenCheckBox,
                                value: todo.complete,
                                onChanged: (_) {
                                  todosBloc.dispatch(UpdateTodo(
                                      todo.copyWith(complete: !todo.complete)));
                                },
                              ),
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Hero(
                                    tag: '${todo.id}__heroTag',
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding:
                                          EdgeInsets.only(top: 8, bottom: 16),
                                      child: Text(
                                        todo.task,
                                        key: ArchSampleKeys.detailsTodoItemTask,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline,
                                      ),
                                    )),
                                Text(
                                  todo.note,
                                  style: Theme.of(context).textTheme.subhead,
                                  key: ArchSampleKeys.detailsTodoItemNote,
                                ),
                              ],
                            )),
                          ],
                        )
                      ],
                    ),
                  ),
            floatingActionButton: FloatingActionButton(
              onPressed: todo == null
                  ? null
                  : () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return AddEditScreen(
                            key: ArchSampleKeys.editTodoScreen,
                            onSave: (task, note) {
                              todosBloc.dispatch(UpdateTodo(
                                  todo.copyWith(task: task, note: note)));
                            },
                            isEditing: true,
                            todo: todo);
                      }));
                    },
              key: ArchSampleKeys.editTodoFab,
              child: Icon(Icons.edit),
              tooltip: localizations.editTodo,
            ),
          );
        });
  }

  final String id;

  DetailsScreen({Key key, @required this.id})
      : super(key: key ?? ArchSampleKeys.todoDetailsScreen);
}
