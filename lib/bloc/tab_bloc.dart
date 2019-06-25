import 'package:bloc/bloc.dart';
import 'package:flutter_todos/bloc/tab_event.dart';
import 'package:flutter_todos/bloc/app_tab.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  @override
  AppTab get initialState => AppTab.todos;

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is UpdateEvent) {
      yield event.appTab;
    }
  }
}
