import 'package:bloc/bloc.dart';
import 'dart:async';
import 'stats_event.dart';
import 'stats_state.dart';
import 'todos_bloc.dart';
import 'todos_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final TodosBloc todoBloc;
  StreamSubscription todoSubscription;

  StatsBloc(this.todoBloc) {
    todoSubscription = todoBloc.state.listen((value) {
      if (value is TodoLoaded) {
        dispatch(UpdateState(value.list));
      }
    });
  }

  @override
  StatsState get initialState => StatsLoading();

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is UpdateState) {
      int numberA =
          event.todos.where((value) => !value.complete).toList().length;
      int numberC =
          event.todos.where((value) => value.complete).toList().length;
      yield StatsLoaded(numberA, numberC);
    }
  }

  @override
  void dispose() {
    todoSubscription.cancel();
    super.dispose();
  }
}
