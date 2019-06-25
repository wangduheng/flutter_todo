export 'todos_bloc.dart';
export 'todos_event.dart';
export 'todos_state.dart';
export 'filter_bloc.dart';
export 'filter_event.dart';
export 'filter_state.dart';
export 'tab_bloc.dart';
export 'tab_event.dart';
export 'stats_bloc.dart';
export 'stats_event.dart';
export 'stats_state.dart';
export 'app_tab.dart';

import 'package:bloc/bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}
