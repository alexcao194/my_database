import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_database/bloc/home_page_bloc/home_page_event.dart';
import 'package:my_database/bloc/home_page_bloc/home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState>{
  HomePageBloc() : super(const HomePageStateInit()) {
   on<HomePageEventChangePage>(_onChange);
  }

  FutureOr<void> _onChange(HomePageEventChangePage event, Emitter emit) {
    emit(HomePageStateChanged(page: event.page));
  }
}