import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_database/bloc/date_picker_bloc/date_picker_bloc.dart';
import 'package:my_database/bloc/date_picker_bloc/date_picker_event.dart';
import 'package:my_database/bloc/date_picker_bloc/date_picker_state.dart';
import 'package:my_database/bloc/login_bloc/user_bloc.dart';
import 'package:my_database/bloc/login_bloc/user_event.dart';
import 'package:my_database/bloc/login_bloc/user_state.dart';
import 'package:my_database/strings.dart';
import 'package:my_database/themes.dart';
import 'package:my_database/ui/widgets/Input_text.dart';
import 'package:my_database/ui/widgets/primary_button.dart';

class RegistryInformation extends StatelessWidget {
  RegistryInformation({Key? key}) : super(key: key);

  final displayNameController = TextEditingController();
  final nickNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          return BlocBuilder<DatePickerBloc, DatePickerState>(
            builder: (context, dateState) {
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
                            Expanded(child: Text('Thông tin', style: TextStyle(fontSize: 30, fontFamily: Themes().headerFont2))),
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: SizedBox(
                                height: 300.0,
                                width: 300.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(300.0),
                                  child: Image.network(
                                    Strings().defaultAvatar,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Container(height: 64, color: Colors.transparent),
                            InputText(label: 'Họ và tên', controller: displayNameController),
                            const SizedBox(height: 8.0),
                            InputText(label: 'Nickname', controller: nickNameController),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<DatePickerBloc>(context).add(DatePickerEventOnPick(currentTime: dateState.time, context: context));
                              },
                              child: InputText(
                                  label:  simpleDateFormat(dateState.time),
                                  enable: false
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(),
                                  PrimaryButton(
                                    onTap: () {
                                      BlocProvider.of<UserBloc>(context).add(
                                          UserEventRegistry(
                                              displayName: displayNameController.value.text,
                                              avatarURL: Strings().defaultAvatar,
                                              birthday: simpleDateFormat(dateState.time),
                                              nickName: nickNameController.value.text
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
                              userState is UserStateRegistryFail ? userState.error : "",
                              style: const TextStyle(
                                  color: Colors.red
                              ),
                            ),
                            Text(
                              userState is UserStateRegistrySuccessful ? userState.status : "",
                              style: TextStyle(
                                  color: Themes().theme.primaryColor
                              ),
                            ),
                            const Expanded(child: SizedBox()),
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

  simpleDateFormat(DateTime time) {
    final localTime = time.toLocal();
    return '${localTime.day}/${localTime.month}/${localTime.year}';
  }


}
