import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_database/bloc/data_bloc/data_bloc.dart';
import 'package:my_database/bloc/data_bloc/data_event.dart';
import 'package:my_database/bloc/data_bloc/data_state.dart';
import 'package:my_database/bloc/home_page_bloc/home_page_bloc.dart';
import 'package:my_database/bloc/home_page_bloc/home_page_event.dart';
import 'package:my_database/bloc/home_page_bloc/home_page_state.dart';
import 'package:my_database/bloc/login_bloc/user_bloc.dart';
import 'package:my_database/bloc/login_bloc/user_state.dart';
import 'package:my_database/themes.dart';
import 'package:my_database/ui/screens/home_screen/pages/account_page.dart';
import 'package:my_database/ui/screens/home_screen/pages/file_page.dart';
import 'package:my_database/ui/screens/home_screen/pages/media_page.dart';
import 'package:my_database/ui/widgets/account_form_dialog.dart';
import 'package:my_database/ui/widgets/header.dart';
import 'package:my_database/ui/widgets/primary_button.dart';
import 'package:my_database/ui/widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final pageViewController = PageController(
    initialPage: 0
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        return BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, homePageState) {
            return BlocBuilder<DataBloc, DataState>(
              builder: (context, dataState) {
                return Scaffold(
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          userState is UserStateLoginSuccessful
                              ? Header(user: userState.user)
                              : const SizedBox(),
                          const SizedBox(height: 8.0),
                          SearchBar(),
                          const SizedBox(height: 16.0),
                          Text('My Database',
                              style: TextStyle(fontFamily: Themes().headerFont2, fontSize: 32)),
                          const SizedBox(height: 32.0),
                          SizedBox(
                            height: 40.0,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                PrimaryButton(
                                  onTap: () {
                                    BlocProvider.of<DataBloc>(context).add(
                                        DataEventGet(
                                            idTab: HomePage.account,
                                            user: userState is UserStateLoginSuccessful ? userState.user : null
                                        )
                                    );
                                    pageViewController.jumpToPage(0);
                                  },
                                  radius: 10.0,
                                  label: 'Tài khoản',
                                  isCheck: homePageState.page == HomePage.account,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: PrimaryButton(
                                    onTap: () {
                                      pageViewController.jumpToPage(1);
                                    },
                                    radius: 10.0,
                                    label: 'Thư viện',
                                    isCheck: homePageState.page == HomePage.media,
                                  ),
                                ),
                                PrimaryButton(
                                  onTap: () {
                                    pageViewController.jumpToPage(2);
                                  },
                                  radius: 10.0,
                                  label: 'Tệp tin',
                                  isCheck: homePageState.page == HomePage.file,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              child: PageView(
                                controller: pageViewController,
                                onPageChanged: (index) {
                                  BlocProvider.of<HomePageBloc>(context).add(HomePageEventChangePage(page: HomePage.values[index]));
                                },
                                children: const [
                                  AccountPage(),
                                  MediaPage(),
                                  FilePage(),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  floatingActionButton: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        BlocProvider.of<DataBloc>(context).add(DataEventCallForm(context: context, accountFormMode: AccountFormMode.add));
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                );
              }
            );
          },
        );
      }
    );
  }
}
