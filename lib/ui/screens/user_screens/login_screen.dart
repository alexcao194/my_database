import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_database/bloc/data_bloc/data_bloc.dart';
import 'package:my_database/bloc/data_bloc/data_state.dart';
import 'package:my_database/bloc/login_bloc/user_bloc.dart';
import 'package:my_database/bloc/login_bloc/user_event.dart';
import 'package:my_database/bloc/login_bloc/user_state.dart';
import 'package:my_database/themes.dart';
import 'package:my_database/ui/screens/user_screens/lost_password_screen.dart';
import 'package:my_database/ui/screens/user_screens/sign_up_screen.dart';
import 'package:my_database/ui/widgets/Input_text.dart';
import 'package:my_database/ui/widgets/primary_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    loadPreferences();
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        return BlocBuilder<DataBloc, DataState>(
          builder: (context, dataState) {
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
                          Expanded(child: Text('Đăng nhập', style: TextStyle(fontSize: 30, fontFamily: Themes().headerFont2))),
                          const SizedBox(height: 64.0),
                          InputText(label: 'Email', controller: emailController, hidePassword: false),
                          const SizedBox(height: 8.0),
                          InputText(label: 'Mật khẩu', controller: passwordController, hidePassword: true),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => LostPasswordScreen()));
                                  },
                                  child: Text(
                                      'Quên mật khẩu',
                                      style: TextStyle(
                                          fontFamily: Themes().headerFont1,
                                          color: Themes().theme.primaryColor,
                                          decoration: TextDecoration.underline
                                      )
                                  ),
                                ),
                                PrimaryButton(
                                  onTap: () {
                                    setPreferences(emailController.value.text);
                                    BlocProvider.of<UserBloc>(context).add(
                                        UserEventLogin(
                                            context: context,
                                            email: emailController.value.text,
                                            password: passwordController.value.text
                                        )
                                    );
                                  },
                                  radius: 5.0,
                                  label: 'Đăng nhập',
                                  isCheck: false,
                                )
                              ],
                            ),
                          ),
                          Text(
                              userState is UserStateLoginFail ? userState.error : '',
                              style: const TextStyle(
                                color: Colors.red,
                              )
                          ),
                          const Expanded(child: SizedBox()),
                          Center(
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                                },
                                child: Text(
                                  'SignUp',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Themes().theme.primaryColor
                                  ),
                                )
                            ),
                          ),
                          const SizedBox(height: 8.0)
                        ],
                      ),
                      userState is UserStateLoading ? const CircularProgressIndicator() : const SizedBox()
                    ],
                  ),
                ),
              ),
            );
          }
        );
      }
    );
  }

  void loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    emailController.text = prefs.getString('email') ?? '';
  }

  void setPreferences(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
  }
}
