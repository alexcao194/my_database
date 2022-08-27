import 'package:equatable/equatable.dart';
enum HomePage {
  account,
  media,
  file
}

abstract class HomePageState extends Equatable {
  const HomePageState({required this.page});
  final HomePage page;

  @override
  List<Object> get props => [page];
}

class HomePageStateInit extends HomePageState {
  const HomePageStateInit() : super(page: HomePage.account);

  @override
  List<Object> get props =>[page];
}

class HomePageStateChanged extends HomePageState {
  const HomePageStateChanged({required super.page});

  @override
  List<Object> get props =>[page];
}