import 'package:equatable/equatable.dart';
import 'package:flutter_todos/pojo/todo.dart';

abstract class StatsEvent extends Equatable {
  StatsEvent({List prop = const []}) : super(prop);
}

class UpdateState extends StatsEvent {
  final List<Todo> todos;

  UpdateState(this.todos) : super(prop: [todos]);

  @override
  String toString() {
    return 'UpdateState{todos: $todos}';
  }

}
