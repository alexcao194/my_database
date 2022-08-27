import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_database/bloc/data_bloc/data_bloc.dart';
import 'package:my_database/bloc/data_bloc/data_event.dart';
import 'package:my_database/bloc/data_bloc/data_state.dart';
import 'package:my_database/bloc/home_page_bloc/home_page_state.dart';
import 'package:my_database/bloc/login_bloc/user_bloc.dart';
import 'package:my_database/bloc/login_bloc/user_state.dart';
import 'package:my_database/themes.dart';

class SearchBar extends StatelessWidget {
  SearchBar({Key? key}) : super(key: key);
  
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        return BlocBuilder<DataBloc, DataState>(
          builder: (context, dataState) {
            return Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 48.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color.fromARGB(100, 215, 215, 215)),
                    child: Center(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextField(
                                controller: searchController,
                                decoration: const InputDecoration.collapsed(hintText: 'Tìm Kiếm...'),
                                cursorColor: Themes().theme.primaryColor,
                                textInputAction: TextInputAction.search,
                                onSubmitted: (value) {
                                  BlocProvider.of<DataBloc>(context).add(
                                      DataEventGet(
                                          idTab: HomePage.account,
                                          user: userState is UserStateLoginSuccessful ? userState.user : null,
                                          value: searchController.value.text
                                      )
                                  );
                                },
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              BlocProvider.of<DataBloc>(context).add(
                                  DataEventGet(
                                      idTab: HomePage.account,
                                      user: userState is UserStateLoginSuccessful ? userState.user : null,
                                      value: searchController.value.text
                                  )
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const Expanded(child: SizedBox())
              ],
            );
          }
        );
      },
    );
  }
}
