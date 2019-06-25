import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todos/bloc/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/localization.dart';
import 'package:flutter_todos/pojo/pojo.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';
import 'package:path_provider/path_provider.dart';
import 'screens/screens.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    BlocProvider(
      builder: (context) {
        return TodosBloc(
          repositoryFlutter: const TodosRepositoryFlutter(
            fileStorage: const FileStorage(
              '__flutter_bloc_app__',
              getApplicationDocumentsDirectory,
            ),
          ),
        )..dispatch(LoadTodos());
      },
      child: TodosApp(),
    ),
  );
}

class TodosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var todosBloc = BlocProvider.of<TodosBloc>(context);
    return MaterialApp(
      title: FlutterBlocLocalizations().appTitle,
      theme: ArchSampleTheme.theme,
      localizationsDelegates: [
        ArchSampleLocalizationsDelegate(),
        FlutterBlocLocalizationsDelegate(),
      ],
      routes: {
        ArchSampleRoutes.home: (context) {
          return BlocProviderTree(blocProviders: [
            BlocProvider<TabBloc>(builder: (context) => TabBloc(),),
            BlocProvider<FilteredTodosBloc>(builder: (context) => FilteredTodosBloc(todosBloc)),
            BlocProvider<StatsBloc>(builder: (context) => StatsBloc(todosBloc)),], child: HomeScreen());
        },
        ArchSampleRoutes.addTodo: (context) {
          return AddEditScreen(
            key: ArchSampleKeys.addTodoScreen,
            onSave: (task, note) {
              todosBloc.dispatch(AddTodo(todo: Todo(task, note: note)));
            },
            isEditing: false,
          );
        }
      },
    );
  }
}
