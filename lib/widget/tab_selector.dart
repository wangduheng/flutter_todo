import 'package:flutter/material.dart';
import 'package:flutter_todos/bloc/blocs.dart';
import 'package:todos_app_core/todos_app_core.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  TabSelector({Key key, @required this.activeTab, @required this.onTabSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
            icon: Icon(
              tab == AppTab.todos ? Icons.list : Icons.show_chart,
              key: tab == AppTab.todos
                  ? ArchSampleKeys.todoTab
                  : ArchSampleKeys.statsTab,
            ),
            title: Text((tab == AppTab.stats
                ? ArchSampleLocalizations.of(context).stats
                : ArchSampleLocalizations.of(context).todos)));
      }).toList(),
      key: ArchSampleKeys.tabs,
      onTap: (index) => onTabSelected(AppTab.values[index]),
      currentIndex: AppTab.values.indexOf(activeTab),
    );
  }
}
