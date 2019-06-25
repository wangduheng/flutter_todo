import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_todos/pojo/todo.dart';
import 'package:flutter_todos/pojo/visibility_filter.dart';
import 'package:meta/meta.dart';
import 'filter_event.dart';
import 'filter_state.dart';
import 'todos_bloc.dart';
import 'todos_state.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  final TodosBloc todosBloc;
  StreamSubscription todoSubscription;

  FilteredTodosBloc(@required this.todosBloc) {
    todoSubscription = todosBloc.state.listen((value) {
      if (value is TodoLoaded) {
        dispatch(UpdateTodos((todosBloc.currentState as TodoLoaded).list));
      }
    });
  }

  @override
  FilteredTodosState get initialState {
    return todosBloc.currentState is TodoLoaded
        ? FilteredTodosLoaded(
            ((todosBloc.currentState) as TodoLoaded).list, VisibilityFilter.all)
        : FilteredTodosLoading();
  }

  @override
  Stream<FilteredTodosState> mapEventToState(FilteredTodosEvent event) async* {
    if (event is UpdateFilter) {
      yield* mapUpdateFilterToState(event);
    }
    if (event is UpdateTodos) {
      yield* mapUpdateTodosToState(event);
    }
  }

  Stream<FilteredTodosState> mapUpdateFilterToState(UpdateFilter event) async* {
    if (todosBloc.currentState is TodoLoaded) {
      yield FilteredTodosLoaded(
          _mapTodosToFilterTodos(
              (todosBloc.currentState as TodoLoaded).list, event.filter),
          event.filter);
    }
  }

  Stream<FilteredTodosState> mapUpdateTodosToState(UpdateTodos event) async* {
    final visibilityFiler = currentState is FilteredTodosLoaded
        ? (currentState as FilteredTodosLoaded).activeFilter
        : VisibilityFilter.all;
    yield FilteredTodosLoaded(
        _mapTodosToFilterTodos(
            (todosBloc.currentState as TodoLoaded).list, visibilityFiler),
        visibilityFiler);
  }

  List<Todo> _mapTodosToFilterTodos(List<Todo> todos, VisibilityFilter filter) {
    return todos.where((value) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !value.complete;
      } else if (filter == VisibilityFilter.completed) {
        return value.complete;
      } else {
        return true;
      }
    }).toList();
  }

  @override
  void dispose() {
    todoSubscription.cancel();
    super.dispose();
  }
}
