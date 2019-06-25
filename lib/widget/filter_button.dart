import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/bloc/blocs.dart';
import 'package:flutter_todos/pojo/visibility_filter.dart';
import 'package:todos_app_core/todos_app_core.dart';

class FilterButton extends StatelessWidget {
  final bool visible;

  FilterButton({Key key, this.visible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle defaultStyle = Theme.of(context).textTheme.body1;
    final TextStyle activeStyle = Theme.of(context)
        .textTheme
        .body1
        .copyWith(color: Theme.of(context).accentColor);

    final FilteredTodosBloc filteredTodosBloc =
        BlocProvider.of<FilteredTodosBloc>(context);

    return BlocBuilder(
        bloc: filteredTodosBloc,
        builder: (context, FilteredTodosState state) {
          final button = _Button(
            onSelected: (filter) =>
                filteredTodosBloc.dispatch(UpdateFilter(filter)),
            visibilityFilter: (state is FilteredTodosLoaded)
                ? state.activeFilter
                : VisibilityFilter.all,
            defaultStyle: defaultStyle,
            activeStyle: activeStyle,
          );

          return AnimatedOpacity(
              child: visible
                  ? button
                  : IgnorePointer(
                      child: button,
                    ),
              opacity: visible ? 1 : 0,
              duration: Duration(milliseconds: 10000));
        });
  }
}

class _Button extends StatelessWidget {
  final TextStyle defaultStyle;
  final TextStyle activeStyle;
  final VisibilityFilter visibilityFilter;
  final PopupMenuItemSelected<VisibilityFilter> onSelected;

  _Button(
      {Key key,
      @required this.defaultStyle,
      @required this.activeStyle,
      @required this.visibilityFilter,
      @required this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<VisibilityFilter>(
        key: ArchSampleKeys.filterButton,
        tooltip: ArchSampleLocalizations.of(context).filterTodos,
        onSelected: onSelected,
        icon: Icon(Icons.filter_list),
        itemBuilder: (context) => [
              PopupMenuItem<VisibilityFilter>(
                key: ArchSampleKeys.allFilter,
                value: VisibilityFilter.all,
                child: Text(
                  ArchSampleLocalizations.of(context).showAll,
                  style: visibilityFilter == VisibilityFilter.all
                      ? activeStyle
                      : defaultStyle,
                ),
              ),
              PopupMenuItem<VisibilityFilter>(
                key: ArchSampleKeys.activeFilter,
                value: VisibilityFilter.active,
                child: Text(
                  ArchSampleLocalizations.of(context).showActive,
                  style: visibilityFilter == VisibilityFilter.active
                      ? activeStyle
                      : defaultStyle,
                ),
              ),
              PopupMenuItem<VisibilityFilter>(
                key: ArchSampleKeys.completedFilter,
                value: VisibilityFilter.completed,
                child: Text(
                  ArchSampleLocalizations.of(context).showCompleted,
                  style: visibilityFilter == VisibilityFilter.completed
                      ? activeStyle
                      : defaultStyle,
                ),
              ),
            ]);
  }
}
