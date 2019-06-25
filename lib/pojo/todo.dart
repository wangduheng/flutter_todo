import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

@immutable
class Todo extends Equatable {
  final bool complete;
  final String id;
  final String note;
  final String task;

  Todo(this.task, {
    this.complete = false,
    String id,
    String note = '',
  })
      : this.note = note ?? '',
        this.id = id ?? Uuid().generateV4(),
        super([complete, id, note, task]);

  @override
  String toString() {
    return 'Todo{complete: $complete, id: $id, note: $note, task: $task}';
  }

  TodoEntity toEntity() {
    return TodoEntity(task, id, note, complete);
  }

  static Todo fromEntity(TodoEntity entity) {
    return Todo(entity.task,
        id: entity.id ?? Uuid().generateV4(),
        note: entity.note,
        complete: entity.complete ?? false);
  }

  Todo copyWith({bool complete, String id, String note, String task}) {
    return Todo(task ?? this.task, complete: complete ?? this.complete,
        id: id ?? this.id,
        note: note ?? this.note);
  }
}
