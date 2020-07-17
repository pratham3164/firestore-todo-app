part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final String getUserId;

  const AuthenticationSuccess(this.getUserId);

  @override
  String toString() => 'UserId: $getUserId';

  @override
  List<Object> get props => [getUserId];
}

class AuthenticationFailed extends AuthenticationState {}
