import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_database/bloc/login_bloc/user_bloc.dart';
import 'package:my_database/bloc/login_bloc/user_event.dart';
import 'package:my_database/bloc/login_bloc/user_state.dart';
import 'package:my_database/themes.dart';
import 'package:my_database/ui/widgets/Input_text.dart';
import 'package:my_database/ui/widgets/primary_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

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
                      Expanded(child: Text('Đăng kí', style: TextStyle(fontSize: 30, fontFamily: Themes().headerFont2))),
                      Container(height: 64, color: Colors.transparent),
                      InputText(label: 'Email', controller: emailController),
                      const SizedBox(height: 8.0),
                      InputText(label: 'Mật khẩu', controller: passwordController, hidePassword: true),
                      const SizedBox(height: 8.0),
                      InputText(label: 'Nhập lại mật khẩu', controller: rePasswordController, hidePassword: true),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(),
                            PrimaryButton(
                                onTap: () {
                                  setPreferences(emailController.value.text);
                                  BlocProvider.of<UserBloc>(context).add(
                                      UserEventSignUp(
                                          email: emailController.value.text,
                                          password: passwordController.value.text,
                                          rePassword: rePasswordController.value.text,
                                          context: context
                                      )
                                  );
                                },
                                radius: 5.0,
                                label: 'Đăng kí',
                                isCheck: false,
                            )
                          ],
                        ),
                      ),
                      Text(
                        state is UserStateSignUpFail ? state.error : "",
                        style: const TextStyle(
                            color: Colors.red
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

  setPreferences(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
  }
}
