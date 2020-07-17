import 'package:flutter/material.dart';
import 'package:todo/model/app_tab.dart';

class TabSelector extends StatelessWidget {
  final Function(AppTab) onSelected;
  final AppTab activeTab;

  const TabSelector({Key key, this.onSelected, this.activeTab})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: activeTab == AppTab.todos ? 0 : 1,
      onTap: (index) => onSelected(AppTab.values[index]),
      items: AppTab.values
          .map((tab) => BottomNavigationBarItem(
              icon: Icon(
                tab == AppTab.todos ? Icons.list : Icons.show_chart,
              ),
              title: Text(
                tab == AppTab.todos ? 'ToDo\'s' : 'Stats',
              )))
          .toList(),
    );
  }
}
