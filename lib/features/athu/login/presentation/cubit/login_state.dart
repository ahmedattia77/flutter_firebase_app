part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginError extends LoginState {
  final String message;
  LoginError({required this.message});
}

// register
final class RegisterLoading extends LoginState {}

final class RegisterSuccess extends LoginState {}

final class RegisterError extends LoginState {
  final String message;
  RegisterError({required this.message});
}
