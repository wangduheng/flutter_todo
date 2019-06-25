import 'package:equatable/equatable.dart';
import 'package:flutter_todos/pojo/todo.dart';

abstract class TodosState extends Equatable {
  TodosState({List prop = const []}) : super(prop);
}

class TodoLoading extends TodosState {
  @override
  String toString() {
    return 'TodoLoading{}';
  }
}

class TodoNotLoaded extends TodosState {
  TodoNotLoaded();
}

class TodoLoaded extends TodosState {
  final List<Todo> list;

  TodoLoaded({this.list = const []}) : super(prop: [list]);

  @override
  String toString() {
    return 'TodoLoaded{list: $list}';
  }
}
