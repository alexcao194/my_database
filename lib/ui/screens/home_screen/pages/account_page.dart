import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_database/bloc/data_bloc/data_bloc.dart';
import 'package:my_database/bloc/data_bloc/data_state.dart';
import 'package:my_database/model/account.dart';
import 'package:my_database/ui/screens/home_screen/pages/empty_page.dart';
import 'package:my_database/ui/widgets/account_card.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(builder: (context, dataState) {
      List<Account> accounts =
          dataState is DataStateGetSuccessful ? dataState.accounts : [];
      return dataState is DataStateLoading
          ? const Center(child: CircularProgressIndicator())
          : (accounts.isEmpty
              ? const EmptyPage()
              : Center(
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListView.builder(
                        itemCount: accounts.length,
                        itemBuilder: (context, index) {
                          return AccountCard(account: accounts[index]);
                        },
                      ),
                    ),
                  ),
                ));
    });
  }
}
