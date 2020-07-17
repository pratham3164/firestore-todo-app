import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/blocs.dart';
import 'package:todo/model/app_tab.dart';
import 'package:todo/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabsBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text('ToDo'),
            actions: [
              FilterButton(visible: activeTab == AppTab.todos),
              ExtraActions(),
            ],
          ),
          body: activeTab == AppTab.todos ? FilteredTodo() : Stats(),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/addEditScreen');
              },
              child: Icon(Icons.add)),
          bottomNavigationBar: TabSelector(
              onSelected: (tab) =>
                  BlocProvider.of<TabsBloc>(context).add(TabsUpdated(tab)),
              activeTab: activeTab),
        );
      },
    );
  }
}
