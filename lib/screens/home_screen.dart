import 'package:flutter/material.dart';
import 'package:flutter_todos/bloc/blocs.dart';
import 'package:flutter_todos/widget/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';
import '../localization.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen() : super(key: ArchSampleKeys.homeScreen);

  @override
  Widget build(BuildContext context) {
    print("build HomeScreen");
    TabBloc tabBloc = BlocProvider.of<TabBloc>(context);
    return BlocBuilder(
        bloc: tabBloc,
        builder: (context, AppTab activeTab) {
          return Scaffold(
            appBar: AppBar(
              title: Text(FlutterBlocLocalizations.of(context).appTitle),
              actions: <Widget>[
                FilterButton(visible: activeTab == AppTab.todos),
                ExtraActions(),
              ],
            ),
            body: activeTab == AppTab.todos ? FilteredTodos() : Stats(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, ArchSampleRoutes.addTodo);
              },
              key: ArchSampleKeys.addTodoFab,
              child: Icon(Icons.add),
              tooltip: ArchSampleLocalizations.of(context).todos,
            ),
            bottomNavigationBar: TabSelector(
                activeTab: activeTab,
                onTabSelected: (tab) => tabBloc.dispatch(UpdateEvent(tab))),
          );
        });
  }
}
