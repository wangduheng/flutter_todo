import 'package:bloc/bloc.dart';
import 'package:flutter_todos/pojo/todo.dart';
import 'package:meta/meta.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';

import 'todos_event.dart';
import 'todos_state.dart';

class TodosBloc extends Bloc<TodoEvent, TodosState> {
  final TodosRepositoryFlutter repositoryFlutter;

  TodosBloc({@required this.repositoryFlutter});

  @override
  TodosState get initialState => TodoLoading();

  @override
  Stream<TodosState> mapEventToState(TodoEvent event) async* {
    if (event is LoadTodos) {
      yield* mapLoadTodosToState(event);
    }
    if (event is AddTodo) {
      yield* mapAddTodoToState(event);
    }
    if (event is DeleteTodo) {
      yield* mapDeleteToState(event);
    }
    if (event is UpdateTodo) {
      yield* mapUpdateToState(event);
    }
    if (event is ClearedComplete) {
      yield* mapClearToState(event);
    }
    if (event is ToggleAll) {
      yield* mapToggleToState(event);
    }
  }

  Stream<TodosState> mapLoadTodosToState(LoadTodos event) async* {
    try {
      var todos = await repositoryFlutter.loadTodos();
      yield TodoLoaded(list: todos.map(Todo.fromEntity).toList());
    } catch (e) {
      yield TodoNotLoaded();
    }
  }

  Stream<TodosState> mapAddTodoToState(AddTodo event) async* {
    if (currentState is TodoLoaded) {
      final List<Todo> updateTodos =
          List.from((currentState as TodoLoaded).list)..add(event.todo);
      yield TodoLoaded(list: updateTodos);
      _saveTodos(updateTodos);
    }
  }

  _saveTodos(List<Todo> todos) {
    return repositoryFlutter.saveTodos(
      todos.map((todo) => todo.toEntity()).toList(),
    );
  }

  Stream<TodosState> mapDeleteToState(DeleteTodo event) async* {
    print("mapDeleteToState");
    if (currentState is TodoLoaded) {
      final updatedTodos = (currentState as TodoLoaded)
          .list
          .where((todo) => todo.id != event.deleteTodo.id)
          .toList();
      print("delete id is : ${event.deleteTodo.id}");
      yield TodoLoaded(list: updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> mapUpdateToState(UpdateTodo event) async* {
    if (currentState is TodoLoaded) {
      final List<Todo> updatedTodos =
          (currentState as TodoLoaded).list.map((todo) {
        return todo.id == event.updateTodo.id ? event.updateTodo : todo;
      }).toList();
      yield TodoLoaded(list: updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> mapClearToState(ClearedComplete event) async* {
    if (currentState is TodoLoaded) {
      final List<Todo> updatedTodos = (currentState as TodoLoaded)
          .list
          .where((todo) => !todo.complete)
          .toList();

      yield TodoLoaded(list: updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> mapToggleToState(ToggleAll event) async* {
    print("mapToggleToState:${currentState}");
    if (currentState is TodoLoaded) {
      final allComplete =
          (currentState as TodoLoaded).list.every((value) => value.complete);
      final List<Todo> updateTodos = (currentState as TodoLoaded)
          .list
          .map((value) => value.copyWith(complete: !allComplete))
          .toList();
      yield TodoLoaded(list: updateTodos);
      _saveTodos(updateTodos);
    }
  }
}
