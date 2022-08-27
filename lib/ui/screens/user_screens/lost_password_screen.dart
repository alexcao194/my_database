import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_database/bloc/login_bloc/user_bloc.dart';
import 'package:my_database/bloc/login_bloc/user_event.dart';
import 'package:my_database/bloc/login_bloc/user_state.dart';
import 'package:my_database/themes.dart';
import 'package:my_database/ui/widgets/Input_text.dart';

class LostPasswordScreen extends StatelessWidget {
  LostPasswordScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 32.0),
                        Text('Alex Database',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w900,
                              color: Themes().theme.primaryColor,
                            )
                        ),
                        const SizedBox(height: 4.0),
                        Expanded(child: Text('Quên mật khẩu', style: TextStyle(fontSize: 30, fontFamily: Themes().headerFont2))),
                        Container(height: 64, color: Colors.transparent),
                        InputText(label: 'Email', controller: emailController, hidePassword: false),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Material(
                                  color:Colors.transparent,
                                  child: InkWell(
                                      splashColor: Themes().theme.primaryColor,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          const BorderRadius.all(Radius.circular(5.0)),
                                          border: Border.all(color: Themes().theme.primaryColor, width: 1.5),
                                        ),
                                        height: 40.0,
                                        width: 100.0,
                                        child: Center(
                                            child: Text('Lấy mật khẩu',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Themes().theme.primaryColor,
                                                )
                                            )
                                        ),
                                      ),
                                      onTap: () {
                                        BlocProvider.of<UserBloc>(context).add(UserEventGetPassword(email: emailController.value.text));
                                      }
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Text(
                          state is UserStateGetPasswordFail ? state.error : "",
                          style: const TextStyle(
                              color: Colors.red
                          ),
                        ),
                        Text(
                          state is UserStateGetPasswordSuccessful ? state.status : "",
                          style: TextStyle(
                              color: Themes().theme.primaryColor
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                    state is UserStateLoading ? const CircularProgressIndicator() : const SizedBox()
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
