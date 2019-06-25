import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/bloc/blocs.dart';
import 'package:flutter_todos/flutter_todo_keys.dart';
import 'package:flutter_todos/widget/widgets.dart';
import 'package:todos_app_core/todos_app_core.dart';

class Stats extends StatelessWidget {
  Stats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var statsBloc = BlocProvider.of<StatsBloc>(context);
    return BlocBuilder(
        bloc: statsBloc,
        builder: (context, StatsState state) {
          if (state is StatsLoading) {
            return LoadingIndicator();
          } else if (state is StatsLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      ArchSampleLocalizations.of(context).completedTodos,
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 24),
                    child: Text(
                      '${state.numberComplete}',
                      key: ArchSampleKeys.statsNumCompleted,
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      ArchSampleLocalizations.of(context).activeTodos,
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 24),
                    child: Text(
                      "${state.numberActive}",
                      key: ArchSampleKeys.statsNumActive,
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(key: FlutterTodoKeys.emptyStatsContainer);
          }
        });
  }

}
