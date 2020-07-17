import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/model/app_tab.dart';

part 'tabs_event.dart';

class TabsBloc extends Bloc<TabsEvent, AppTab> {
  TabsBloc() : super(AppTab.todos);

  @override
  Stream<AppTab> mapEventToState(
    TabsEvent event,
  ) async* {
    if (event is TabsUpdated) {
      yield event.tab;
    }
  }
}
