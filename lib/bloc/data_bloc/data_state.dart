import 'package:equatable/equatable.dart';
import 'package:my_database/model/account.dart';

abstract class DataState extends Equatable {
  const DataState();

  @override
  List<Object> get props => [];
}

class DataStateInit extends DataState {

}

class DataStateRemoveSuccessful extends DataState {

}

class DataStateUpdateSuccessful extends DataState {

}

class DataStateGetSuccessful extends DataState {
  final List<Account> accounts;

  const DataStateGetSuccessful({required this.accounts});

  @override
  List<Object> get props => [accounts];
}

class DataStateGetEmpty extends DataState {

}

class DataStateLoading extends DataState {

}
