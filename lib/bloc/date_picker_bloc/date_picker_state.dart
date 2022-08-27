import 'package:equatable/equatable.dart';

abstract class DatePickerState extends Equatable {
  final DateTime time;
  const DatePickerState({required this.time});

  @override
  List<Object> get props => [time];
}

class DatePickerStateInit extends DatePickerState {
  const DatePickerStateInit({required super.time});
}

class DatePickerStateDone extends DatePickerState {
  const DatePickerStateDone({required super.time});
}

class DatePickerStateFail extends DatePickerState {
  final String error;
  const DatePickerStateFail({required this.error,required super.time});

  @override
  List<Object> get props => [error, time];
}