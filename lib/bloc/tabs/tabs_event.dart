part of 'tabs_bloc.dart';

abstract class TabsEvent extends Equatable {
  const TabsEvent();

  @override
  List<Object> get props => [];
}

class TabsUpdated extends TabsEvent {
  final AppTab tab;

  const TabsUpdated(this.tab);

  @override
  List<Object> get props => [tab];

  @override
  String toString() {
    return 'AppTab: $tab';
  }
}
