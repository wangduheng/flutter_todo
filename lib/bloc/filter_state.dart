import 'package:equatable/equatable.dart';
import 'package:flutter_todos/pojo/todo.dart';
import 'package:flutter_todos/pojo/visibility_filter.dart';

abstract class FilteredTodosState extends Equatable {
  FilteredTodosState({List prop = const []}) : super(prop);
}

class FilteredTodosLoading extends FilteredTodosState {
  @override
  String toString() {
    return 'FilteredTodosLoading{}';
  }
}

class FilteredTodosLoaded extends FilteredTodosState {
  final List<Todo> filteredTodos;
  final VisibilityFilter activeFilter;

  FilteredTodosLoaded(this.filteredTodos, this.activeFilter)
      : super(prop: [filteredTodos, activeFilter]);

  @override
  String toString() {
    return 'FilteredTodosLoaded{filteredTodos: $filteredTodos, activeFilter: $activeFilter}';
  }
}
