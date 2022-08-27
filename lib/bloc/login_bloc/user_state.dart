import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserState extends Equatable {
  const UserState();
  @override
  List<Object> get props => [];
}

class UserStateInit extends UserState {

}

class UserStateLoading extends UserState {

}


class UserStateSignUpSuccessful extends UserState {
  const UserStateSignUpSuccessful();

  @override
  List<Object> get props => [];
}

class UserStateSignUpFail extends UserState {
  final String error;
  const UserStateSignUpFail({required this.error});

  @override
  List<Object> get props => [error];
}

class UserStateLoginSuccessful extends UserState {
  final User user;
  const UserStateLoginSuccessful({required this.user});

  @override
  List<Object> get props => [user];
}

class UserStateLoginFail extends UserState {
  final String error;
  const UserStateLoginFail({required this.error});

  @override
  List<Object> get props => [error];
}

class UserStateGetPasswordSuccessful extends UserState {
  final String status;
  const UserStateGetPasswordSuccessful({required this.status});

  @override
  List<Object> get props => [status];
}

class UserStateGetPasswordFail extends UserState {
  final String error;
  const UserStateGetPasswordFail({required this.error});

  @override
  List<Object> get props => [error];
}

class UserStateRegistrySuccessful extends UserState {
  final String status;
  const UserStateRegistrySuccessful({required this.status});

  @override
  List<Object> get props => [status];
}

class UserStateRegistryFail extends UserState {
  final String error;
  const UserStateRegistryFail({required this.error});

  @override
  List<Object> get props => [error];
}