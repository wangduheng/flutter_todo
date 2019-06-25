import 'package:equatable/equatable.dart';
import 'package:flutter_todos/bloc/app_tab.dart';

abstract class TabEvent extends Equatable {
  TabEvent({List prop = const []}) : super(prop);
}

class UpdateEvent extends TabEvent {
  final AppTab appTab;

  UpdateEvent(this.appTab) : super(prop: [appTab]);

  @override
  String toString() {
    return 'UpdateEvent{appTab: $appTab}';
  }
}
