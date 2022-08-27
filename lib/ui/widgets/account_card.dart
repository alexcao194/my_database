import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_database/bloc/data_bloc/data_bloc.dart';
import 'package:my_database/bloc/data_bloc/data_event.dart';
import 'package:my_database/bloc/data_bloc/data_state.dart';
import 'package:my_database/bloc/home_page_bloc/home_page_state.dart';
import 'package:my_database/bloc/login_bloc/user_bloc.dart';
import 'package:my_database/bloc/login_bloc/user_state.dart';
import 'package:my_database/model/account.dart';
import 'package:my_database/themes.dart';
import 'package:my_database/ui/widgets/account_form_dialog.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({Key? key, required this.account}) : super(key: key);

  final Account account;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        return BlocBuilder<DataBloc, DataState>(builder: (context, dataState) {
          return GestureDetector(
            onLongPress: () {
              BlocProvider.of<DataBloc>(context).add(
                DataEventCallForm(
                    context: context,
                    accountFormMode: AccountFormMode.show,
                    account: account,
                )
              );
            },
            child: PopupMenuButton(
              tooltip: "",
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 0,
                  child: Text('Sửa'),
                ),
                const PopupMenuItem(
                  value: 1,
                  child: Text('Xóa'),
                )
              ],
              onSelected: (value) {
                switch (value) {
                  case 0:
                    BlocProvider.of<DataBloc>(context).add(DataEventCallForm(context: context, accountFormMode: AccountFormMode.update, account: account));
                    break;
                  case 1:
                    BlocProvider.of<DataBloc>(context).add(DataEventRemove(
                        idTab: HomePage.account,
                        id: account.id,
                        user: userState is UserStateLoginSuccessful ? userState.user : null,
                        context: context));
                    break;
                }
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Dịch vụ:',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            'Tài khoản:',
                            style: TextStyle(
                                fontFamily: Themes().headerFont1, fontSize: 16),
                          ),
                          Text(
                            'Mật khẩu:',
                            style: TextStyle(
                                fontFamily: Themes().headerFont1, fontSize: 16),
                          )
                        ],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            account.service,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            account.account,
                            style: TextStyle(
                                fontFamily: Themes().headerFont1, fontSize: 16),
                          ),
                          Text(
                            account.password,
                            style: TextStyle(
                                fontFamily: Themes().headerFont1, fontSize: 16),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
