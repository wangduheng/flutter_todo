import 'package:flutter/material.dart';
import 'package:flutter_todos/bloc/blocs.dart';
import 'package:flutter_todos/flutter_todo_keys.dart';
import 'package:flutter_todos/pojo/pojo.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExtraActions extends StatelessWidget {
  ExtraActions() : super(key: ArchSampleKeys.extraActionsButton);

  @override
  Widget build(BuildContext context) {
    TodosBloc _todosBloc = BlocProvider.of<TodosBloc>(context);
    return BlocBuilder(
        bloc: _todosBloc,
        builder: (context, TodosState state) {
          if (state is TodoLoaded) {
            bool allComplete = (_todosBloc.currentState as TodoLoaded)
                .list
                .every((todo) => todo.complete);
            return PopupMenuButton<ExtraAction>(
              onSelected: (action) {
                switch (action) {
                  case ExtraAction.toggleAllComplete:
                    _todosBloc.dispatch(ToggleAll());
                    break;
                  case ExtraAction.clearCompleted:
                    _todosBloc.dispatch(ClearedComplete());
                    break;
                }
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuItem<ExtraAction>>[
                    PopupMenuItem<ExtraAction>(
                      key: ArchSampleKeys.toggleAll,
                      value: ExtraAction.toggleAllComplete,
                      child: Text(allComplete
                          ? ArchSampleLocalizations.of(context)
                              .markAllIncomplete
                          : ArchSampleLocalizations.of(context)
                              .markAllComplete),
                    ),
                    PopupMenuItem<ExtraAction>(
                      key: ArchSampleKeys.clearCompleted,
                      value: ExtraAction.clearCompleted,
                      child: Text(
                        ArchSampleLocalizations.of(context).clearCompleted,
                      ),
                    ),
                  ],
              key: FlutterTodoKeys.extraActionsPopupMenuButton,
            );
          }
          return Container(key: FlutterTodoKeys.extraActionsEmptyContainer);
        });
  }
}
