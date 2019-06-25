import 'package:equatable/equatable.dart';
import 'package:flutter_todos/pojo/todo.dart';

abstract class TodoEvent extends Equatable {
  TodoEvent({List prop = const []}) : super(prop);
}

class LoadTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final Todo todo;

  AddTodo({this.todo}) : super(prop: [todo]);

  @override
  String toString() {
    return 'AddTodo{todos: $todo}';
  }
}

class DeleteTodo extends TodoEvent {
  final Todo deleteTodo;

  DeleteTodo(this.deleteTodo) : super(prop: [deleteTodo]);

  @override
  String toString() {
    return 'DeleteTodo{deleteTodo: $deleteTodo}';
  }
}

class UpdateTodo extends TodoEvent {
  final Todo updateTodo;

  UpdateTodo(this.updateTodo) : super(prop: [updateTodo]);

  @override
  String toString() {
    return 'UpdateTodo{updateTodo: $updateTodo}';
  }
}

class ClearedComplete extends TodoEvent {
  @override
  String toString() {
    return 'ClearedComplete{}';
  }
}

class ToggleAll extends TodoEvent {
  @override
  String toString() {
    return 'ToggleAll{}';
  }
}
