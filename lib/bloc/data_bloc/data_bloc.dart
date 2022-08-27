import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_database/bloc/data_bloc/data_event.dart';
import 'package:my_database/bloc/data_bloc/data_state.dart';
import 'package:my_database/bloc/home_page_bloc/home_page_state.dart';
import 'package:my_database/model/account.dart';
import 'package:my_database/ui/widgets/account_form_dialog.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataStateInit()) {
    on<DataEventCallForm>(_onCallForm);
    on<DataEventAdd>(_onAdd);
    on<DataEventGet>(_onGet);
    on<DataEventRemove>(_onRemove);
    on<DataEventUpdate>(_onUpdate);
  }

  FutureOr<void> _onCallForm(DataEventCallForm event, Emitter emit) {
    showDialog(
        context: event.context,
        builder: (BuildContext context) {
          return AccountFormDialog(accountFormMode: event.accountFormMode, account: event.account);
        });
  }

  FutureOr<void> _onAdd(DataEventAdd event, Emitter emit) async {
    String collection = getTab(event.idTab);
    switch(collection) {
      case 'accounts':
        await FirebaseFirestore.instance
            .collection('users')
            .doc(event.user!.email)
            .collection('accounts')
            .add({
          'service': event.account.service,
          'account': event.account.account,
          'password': event.account.password,
          'note': event.account.note
        }).then((value) async {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(event.user!.email)
              .collection('accounts')
              .doc(value.id)
              .update({
            'id' : value.id
          }).then((value) async {
            BlocProvider.of<DataBloc>(event.context)
                .add(DataEventGet(idTab: HomePage.account, user: event.user));
            Navigator.of(event.context).pop();
          });
        });
    }
  }

  FutureOr<void> _onGet(DataEventGet event, Emitter emit) async {
    String collection = getTab(event.idTab);
    emit(DataStateLoading());
    if(event.value != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(event.user!.email)
          .collection(collection)
          .get()
          .then((value) => emit(DataStateGetSuccessful(
          accounts: Account.toListAccountSearchByName(value.docs, event.value!))))
      // ignore: avoid_print
          .onError((error, stackTrace) => print('Lỗi : $error'));
    } else {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(event.user!.email)
          .collection(collection)
          .get()
          .then((value) => emit(DataStateGetSuccessful(
          accounts: Account.toListAccount(value.docs))))
      // ignore: avoid_print
          .onError((error, stackTrace) => print('Lỗi : $error'));
    }
  }

  FutureOr<void> _onRemove(DataEventRemove event, Emitter emit) async {
    String collection = getTab(event.idTab);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(event.user!.email)
        .collection(collection)
        .doc(event.id)
        .delete().then((value) {
          BlocProvider.of<DataBloc>(event.context).add(DataEventGet(idTab: event.idTab, user: event.user));
    });
  }

  FutureOr<void> _onUpdate(DataEventUpdate event, Emitter emit) async {
    String collection = getTab(event.idTab);
    switch(collection){
      case 'accounts':
        await FirebaseFirestore.instance
            .collection('users')
            .doc(event.user!.email)
            .collection(collection)
            .doc(event.account.id)
            .update({
          'service': event.account.service,
          'account': event.account.account,
          'password': event.account.password,
          'note': event.account.note
        }).then((value) {
          BlocProvider.of<DataBloc>(event.context)
              .add(DataEventGet(idTab: HomePage.account, user: event.user));
          Navigator.of(event.context).pop();
        });
    }
  }

  String getTab(HomePage idTab) {
    switch (idTab) {
      case HomePage.account:
        return 'accounts';
      case HomePage.media:
        return 'medias';
      case HomePage.file:
        return 'files';
    }
  }
}
