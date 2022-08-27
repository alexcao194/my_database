import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_database/bloc/date_picker_bloc/date_picker_event.dart';
import 'package:my_database/bloc/date_picker_bloc/date_picker_state.dart';

class DatePickerBloc extends Bloc<DatePickerEvent, DatePickerState> {
  DatePickerBloc() : super(DatePickerStateInit(time: DateTime.now())) {
    on<DatePickerEventOnPick>(_onPick);
  }

  FutureOr<void> _onPick(DatePickerEventOnPick event, Emitter emit) async {
    await showDatePicker(
        context: event.context,
        initialDate: state.time,
        firstDate: DateTime(1800),
        lastDate: DateTime(2025)
    ).then((value) => emit(DatePickerStateDone(time: value ?? state.time)));
  }
}