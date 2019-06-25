import 'package:equatable/equatable.dart';
import 'package:flutter_todos/pojo/todo.dart';
import 'package:flutter_todos/pojo/visibility_filter.dart';

abstract class FilteredTodosEvent extends Equatable {
  FilteredTodosEvent({List prop = const []}) : super(prop);
}

class UpdateFilter extends FilteredTodosEvent {
  final VisibilityFilter filter;

  @override
  String toString() {
    return 'UpdateFilter{filter: $filter}';
  }

  UpdateFilter(this.filter) : super(prop: [filter]);
}

class UpdateTodos extends FilteredTodosEvent {
  final List<Todo> todos;

  @override
  String toString() {
    return 'UpdateTodos{todos: $todos}';
  }

  UpdateTodos(this.todos) : super(prop: [todos]);
}
