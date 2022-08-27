import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_database/bloc/data_bloc/data_bloc.dart';
import 'package:my_database/bloc/data_bloc/data_event.dart';
import 'package:my_database/bloc/home_page_bloc/home_page_state.dart';
import 'package:my_database/bloc/login_bloc/user_event.dart';
import 'package:my_database/bloc/login_bloc/user_state.dart';
import 'package:my_database/strings.dart';
import 'package:my_database/ui/screens/home_screen/home_screen.dart';
import 'package:my_database/ui/screens/user_screens/registry_information.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserStateInit()) {
    on<UserEventSignUp>(_onSignUp);
    on<UserEventRegistry>(_onRegistry);
    on<UserEventLogin>(_onLogin);
    on<UserEventGetPassword>(_onGetPassword);
    on<UserEventChangePassword>(_onChangePassword);
  }

  FutureOr<void> _onSignUp (UserEventSignUp event, Emitter emit) async {
    emit(UserStateInit());
    if(event.password == '' || event.password == '') {
      emit(UserStateSignUpFail(error: Strings().emptyInput));
    } else if(event.rePassword.compareTo(event.password) == 0) {
      try {
        emit(UserStateLoading());
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password
        )
            .then((value) {
              emit(const UserStateSignUpSuccessful());
          Navigator.pushReplacement(event.context, MaterialPageRoute(builder: (context) => RegistryInformation()));
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          emit(UserStateSignUpFail(error: Strings().invalidPassword));
        } else if (e.code == 'email-already-in-use') {
          emit(UserStateSignUpFail(error: Strings().emailSigned));
        } else if(e.code == 'invalid-email') {
          emit(UserStateSignUpFail(error: Strings().invalidEmail));
        }
      } catch (e) {
          print('lỗi: $e');
        }
    } else {
      emit(UserStateSignUpFail(error: Strings().inComparePassword));
    }
  }

  FutureOr<void> _onLogin(UserEventLogin event, Emitter emit) async {
    emit(UserStateInit());
    try {
      emit(UserStateLoading());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email,
          password: event.password
      ).then((value) {
        if(value.user!.emailVerified) {
          emit(UserStateLoginSuccessful(user: value.user!));
          Navigator.pushReplacement(event.context, MaterialPageRoute(builder: (context) => HomeScreen()));
          BlocProvider.of<DataBloc>(event.context).add(
              DataEventGet(
                user: value.user,
                idTab: HomePage.account
              )
          );
        } else {
          emit(UserStateLoginFail(error: Strings().emailUnverified));
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(UserStateLoginFail(error: Strings().userNotFound));
      } else if (e.code == 'wrong-password') {
        emit(UserStateLoginFail(error: Strings().incorrectPassword));
      } else if(e.code == 'invalid-email') {
        emit(UserStateLoginFail(error: Strings().invalidEmail));
      } else if(e.code == 'unknown') {
        emit(UserStateLoginFail(error: Strings().emptyInput));
      }
      else {
        if (kDebugMode) {
          print('lỗi ${e.code}');
        }
      }
    }
  }

  FutureOr<void> _onGetPassword(UserEventGetPassword event, Emitter emit) async {
    emit(UserStateInit());
    try {
      emit(UserStateLoading());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: event.email)
          .then((value) => emit(UserStateGetPasswordSuccessful(status: Strings().getPasswordSuccessful)));
    } on FirebaseAuthException catch(e) {
      if(e.code == 'unknown') {
        emit(UserStateGetPasswordFail(error: Strings().emptyEmail));
      } else if(e.code == 'invalid-email') {
        emit(UserStateGetPasswordFail(error: Strings().invalidEmail));
      } else if(e.code == 'user-not-found') {
        emit(UserStateGetPasswordFail(error: Strings().userNotFound));
      } else {
        if (kDebugMode) {
          print('Lỗi: ${e.code}');
        }
      }
    }
  }

  FutureOr<void> _onChangePassword(UserEventChangePassword event, Emitter emit) async {

  }

  FutureOr<void> _onRegistry(UserEventRegistry event, Emitter emit) async {
    if(event.nickName == '' || event.displayName == '') {
      emit(UserStateRegistryFail(error: Strings().emptyInformation));
    } else {
      emit(UserStateLoading());
      User? user = FirebaseAuth.instance.currentUser;
      user!.updateDisplayName(event.displayName);
      user.updatePhotoURL(event.avatarURL);
    CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
      userCollection.doc(user.email).set(
        {
          'nick-name' : event.nickName,
          'display-name' : event.displayName,
          'birthday' : event.birthday
        }
      );
      if (!user.emailVerified) {
        try {
          await user.sendEmailVerification()
              .then((value) => emit(UserStateRegistrySuccessful(status: Strings().registrySuccessful)));
        } on FirebaseAuthException catch(e) {
          if (kDebugMode) {
            print(e);
          }}
      }
    }
  }
}