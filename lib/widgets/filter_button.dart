import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/blocs.dart';
import 'package:todo/model/visibility_filter.dart';

class FilterButton extends StatelessWidget {
  final bool visible;

  const FilterButton({Key key, this.visible}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltertodoBloc, FiltertodoState>(
        builder: (context, state) {
      final defaultStyle = Theme.of(context).textTheme.bodyText1;
      final activeStyle = Theme.of(context)
          .textTheme
          .bodyText2
          .copyWith(color: Theme.of(context).accentColor);
      final button = Button(
        activeFilter: (state is FilterTodoLoadSuccess)
            ? state.visibility
            : VisibilityFilter.all,
        activeStyle: activeStyle,
        defaultStyle: defaultStyle,
        onSelect: (filter) {
          BlocProvider.of<FiltertodoBloc>(context).add(FilterUpdated(filter));
        },
      );
      return AnimatedOpacity(
        opacity: visible ? 1.0 : 0.0,
        duration: Duration(seconds: 1),
        child: visible
            ? button
            : IgnorePointer(
                child: button,
              ),
      );
    });
  }
}

class Button extends StatelessWidget {
  final PopupMenuItemSelected<VisibilityFilter> onSelect;
  final TextStyle activeStyle;
  final TextStyle defaultStyle;
  final VisibilityFilter activeFilter;

  const Button(
      {Key key,
      this.onSelect,
      this.activeStyle,
      this.defaultStyle,
      this.activeFilter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<VisibilityFilter>(
      onSelected: onSelect,
      itemBuilder: (context) => <PopupMenuItem<VisibilityFilter>>[
        PopupMenuItem<VisibilityFilter>(
            value: VisibilityFilter.all,
            child: Text(
              'Show All',
              style: activeFilter == VisibilityFilter.all
                  ? activeStyle
                  : defaultStyle,
            )),
        PopupMenuItem<VisibilityFilter>(
            value: VisibilityFilter.active,
            child: Text(
              'Active',
              style: activeFilter == VisibilityFilter.active
                  ? activeStyle
                  : defaultStyle,
            )),
        PopupMenuItem<VisibilityFilter>(
            value: VisibilityFilter.completed,
            child: Text(
              'Completed',
              style: activeFilter == VisibilityFilter.completed
                  ? activeStyle
                  : defaultStyle,
            )),
      ],
      icon: Icon(Icons.filter_list),
    );
  }
}
