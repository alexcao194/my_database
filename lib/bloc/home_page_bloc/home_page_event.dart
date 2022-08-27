import 'package:equatable/equatable.dart';
import 'package:my_database/bloc/home_page_bloc/home_page_state.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class HomePageEventChangePage extends HomePageEvent {
  final HomePage page;
  const HomePageEventChangePage({required this.page});

  @override
  List<Object> get props =>[page];
}