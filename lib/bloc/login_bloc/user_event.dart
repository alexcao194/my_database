import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object> get props => [];
}

class UserEventSignUp extends UserEvent {
  final BuildContext context;
  final String email;
  final String password;
  final String rePassword;
  const UserEventSignUp({required this.email, required this.password, required this.rePassword, required this.context});

  @override
  List<Object> get props => [email, password, rePassword];
}

class UserEventRegistry extends UserEvent {
  final String avatarURL;
  final String displayName;
  final String birthday;
  final String nickName;
  const UserEventRegistry({required this.displayName, required this.avatarURL, required this.birthday, required this.nickName});

  @override
  List<Object> get props => [displayName, avatarURL, birthday];
}

class UserEventLogin extends UserEvent {
  final BuildContext context;
  final String email;
  final String password;
  const UserEventLogin({required this.email, required this.password, required this.context});

  @override
  List<Object> get props => [email, password, context];
}

class UserEventGetPassword extends UserEvent {
  final String email;

  const UserEventGetPassword({required this.email});

  @override
  List<Object> get props => [email];
}

class UserEventChangePassword extends UserEvent {
  final String password;
  final String rePassword;
  const UserEventChangePassword({required this.password, required this.rePassword});

  @override
  List<Object> get props => [password, rePassword];
}
