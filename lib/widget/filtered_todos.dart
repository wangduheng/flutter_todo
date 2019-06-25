import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_todos/bloc/blocs.dart';
import 'package:flutter_todos/flutter_todo_keys.dart';
import 'package:flutter_todos/screens/screens.dart';
import 'package:flutter_todos/widget/todo_item.dart';
import 'package:todos_app_core/todos_app_core.dart';

import 'widgets.dart';

class FilteredTodos extends StatelessWidget {
  FilteredTodos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todosBloc = BlocProvider.of<TodosBloc>(context);
    final filteredTodosBloc = BlocProvider.of<FilteredTodosBloc>(context);
    final i18ns = ArchSampleLocalizations.of(context);

    return BlocBuilder(
        bloc: filteredTodosBloc,
        builder: (context, FilteredTodosState state) {
          if (state is FilteredTodosLoading) {
            return LoadingIndicator();
          } else if (state is FilteredTodosLoaded) {
            final todos = state.filteredTodos;
            return ListView.builder(
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return TodoItem(
                      todo: todo,
                      onDismissed: (direction) {
                        todosBloc.dispatch(DeleteTodo(todo));
                        Scaffold.of(context).showSnackBar(DeleteTodoSnackBar(
                            key: ArchSampleKeys.snackbar,
                            todo: todo,
                            onUndo: () =>
                                todosBloc.dispatch(AddTodo(todo: todo)),
                            localizations: i18ns));
                      },
                      onTap: () async {
                        final removedTodo = await Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return DetailsScreen(id: todo.id);
                        }));
                        if (removedTodo != null) {
                          Scaffold.of(context).showSnackBar(DeleteTodoSnackBar(
                              key: ArchSampleKeys.snackbar,
                              todo: todo,
                              onUndo: () =>
                                  todosBloc.dispatch(AddTodo(todo: todo)),
                              localizations: i18ns));
                        }
                      },
                      onCheckboxChanged: (_) {
                        todosBloc.dispatch(UpdateTodo(
                            todo.copyWith(complete: !todo.complete)));
                      });
                },
                itemCount: todos.length,
                key: ArchSampleKeys.todoList);
          } else {
            return Container(key: FlutterTodoKeys.filteredTodosEmptyContainer);
          }
        });
  }
}
