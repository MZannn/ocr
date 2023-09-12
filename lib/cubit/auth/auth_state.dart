part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginFailed extends AuthState {}

final class LogoutSuccess extends AuthState {}
