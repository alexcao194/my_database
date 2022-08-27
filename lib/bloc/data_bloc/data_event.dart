import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:my_database/bloc/data_bloc/data_bloc.dart';
import 'package:my_database/bloc/home_page_bloc/home_page_state.dart';
import 'package:my_database/model/account.dart';
import 'package:my_database/ui/widgets/account_form_dialog.dart';

abstract class DataEvent extends Equatable {
  const DataEvent();

  @override
  List<Object> get props => [];
}

class DataEventAdd extends DataEvent {
  final Account account;
  final User? user;
  final BuildContext context;
  final HomePage idTab;
  const DataEventAdd(
      {required this.account, required this.user, required this.context, required this.idTab});

  @override
  List<Object> get props => [account, user!, context, idTab];
}

class DataEventCallForm extends DataEvent {
  final BuildContext context;
  final AccountFormMode accountFormMode;
  final Account? account;
  const DataEventCallForm({required this.context, required this.accountFormMode, this.account});

  @override
  List<Object> get props => [context, accountFormMode, account!];
}

class DataEventRemove extends DataEvent {
  final HomePage idTab;
  final String id;
  final User? user;
  final BuildContext context;

  const DataEventRemove(
      {required this.idTab, required this.id, this.user, required this.context});

  @override
  List<Object> get props => [idTab, id, user!, context];
}

class DataEventUpdate extends DataEvent {
  final HomePage idTab;
  final User? user;
  final BuildContext context;
  final Account account;
  const DataEventUpdate({required this.user, required this.context, required this.idTab,required this.account});

  @override
  List<Object> get props => [user!, context, idTab, account];
}

class DataEventGet extends DataEvent {
  final HomePage idTab;
  final User? user;
  final String? value;
  const DataEventGet({required this.idTab, required this.user, this.value});

  @override
  List<Object> get props => [idTab, user!];
}


