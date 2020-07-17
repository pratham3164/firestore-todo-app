import 'package:bloc/bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print('bloc:${bloc.runtimeType}, event:$event');
    super.onEvent(bloc, event);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    print('bloc:${bloc.runtimeType}, error:$error');
    print(stacktrace);
    super.onError(bloc, error, stacktrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('bloc:${bloc.runtimeType}, transition:$transition');
    super.onTransition(bloc, transition);
  }
}
