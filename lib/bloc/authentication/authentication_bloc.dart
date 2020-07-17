import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/repostories/authenticate/firebase_user_repo.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  FirebaseUserRepository _user;
  AuthenticationBloc(FirebaseUserRepository user)
      : assert(user != null),
        _user = user,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final signedIn = await _user.isAuthenticated();
      print(signedIn);
      if (!signedIn) {
        print('authenticating');
        await _user.authenticate();
        print('authenticated');
      }
      yield AuthenticationSuccess(await _user.getUserId());
    } catch (_) {
      yield AuthenticationFailed();
    }
  }
}
