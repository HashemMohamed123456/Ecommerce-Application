part of 'auth_cubit.dart';
abstract class AuthState {}
class AuthInitial extends AuthState {}
class RegistrationLoadingState extends AuthState{}
class RegistrationSuccessState extends AuthState{
  late bool status;
  late String message;
  String? token;
  RegistrationSuccessState({required this.status,required this.message,this.token});
}
class RegistrationErrorState extends AuthState{}
class LoginLoadingState extends AuthState{}
class LoginSuccessState extends AuthState{
  late bool status;
  late String message;
  String? token;
  LoginSuccessState({required this.status,required this.message,this.token});
}
class LoginErrorState extends AuthState{}
