import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_database/bloc/data_bloc/data_bloc.dart';
import 'package:my_database/bloc/data_bloc/data_event.dart';
import 'package:my_database/bloc/data_bloc/data_state.dart';
import 'package:my_database/bloc/home_page_bloc/home_page_state.dart';
import 'package:my_database/bloc/login_bloc/user_bloc.dart';
import 'package:my_database/bloc/login_bloc/user_state.dart';
import 'package:my_database/model/account.dart';
import 'package:my_database/ui/widgets/Input_text.dart';

enum AccountFormMode {
  add,
  update,
  show,
}

class AccountFormDialog extends StatelessWidget {
  AccountFormDialog({Key? key, required this.accountFormMode, this.account}) : super(key: key);

  final AccountFormMode accountFormMode;
  final serviceController = TextEditingController();
  final accountController = TextEditingController();
  final passwordController = TextEditingController();
  final noteController = TextEditingController();
  final Account? account;


  @override
  Widget build(BuildContext context) {
    if (account != null) {
      serviceController.text = account!.service;
      accountController.text = account!.account;
      passwordController.text = account!.password;
      noteController.text = account!.note;
    }
    return BlocBuilder<DataBloc, DataState>(
      builder: (context, dataState) {
        return BlocBuilder<UserBloc, UserState>(
          builder: (context, userState) {
            return AlertDialog(
              title: const Text("Thêm Tài Khoản"),
              content: SizedBox(
                height: 400.0,
                child: Column(
                  children: [
                    InputText(
                        label: 'Dịch vụ',
                        controller: serviceController,
                        enable: accountFormMode == AccountFormMode.show ? false : true
                    ),
                    const SizedBox(height: 8.0),
                    InputText(
                        label: 'Tài khoản',
                        controller: accountController,
                        enable: accountFormMode == AccountFormMode.show ? false : true
                    ),
                    const SizedBox(height: 8.0),
                    InputText(
                        label: 'Mật Khẩu',
                        controller: passwordController,
                        enable: accountFormMode == AccountFormMode.show ? false : true
                    ),
                    TextField(
                      decoration: InputDecoration(
                        label: const Text('Ghi chú'),
                        enabled: accountFormMode == AccountFormMode.show ? false : true
                      ),
                      minLines: 5,
                      maxLines: 5,
                      controller: noteController,
                    )
                  ],
                ),
              ),
              actions: [
                MaterialButton(
                    child: const Text("Hủy"),
                    onPressed: (){
                      Navigator.of(context).pop();
                    }
                ),
                MaterialButton(
                    child: Text(getButtonName(accountFormMode)),
                    onPressed: (){
                      switch (accountFormMode) {
                        case AccountFormMode.add:
                          BlocProvider.of<DataBloc>(context).add(
                              DataEventAdd(
                                  idTab: HomePage.account,
                                  account: Account(
                                      password: passwordController.value.text,
                                      account: accountController.value.text,
                                      note: noteController.value.text,
                                      service: serviceController.value.text,
                                      id: ''
                                  ),
                                  context: context,
                                  user: userState is UserStateLoginSuccessful ? userState.user : null
                              )
                          );
                          break;
                        case AccountFormMode.update:
                          BlocProvider.of<DataBloc>(context).add(
                            DataEventUpdate(
                                user: userState is UserStateLoginSuccessful ? userState.user : null,
                                context: context,
                                idTab: HomePage.account,
                                account: Account(
                                    password: passwordController.value.text,
                                    account: accountController.value.text,
                                    note: noteController.value.text,
                                    service: serviceController.value.text,
                                    id: account!.id
                                )
                            )
                          );
                          break;
                        case AccountFormMode.show:
                          Navigator.of(context).pop();
                      }
                    }
                ),
              ],
            );
          }
        );
      },
    );
  }

  String getButtonName(AccountFormMode accountFormMode) {
    switch(accountFormMode) {
      case AccountFormMode.add:
        return "Thêm";
      case AccountFormMode.update:
        return "Sửa";
      case AccountFormMode.show:
        return "Đóng";
    }
  }
}
