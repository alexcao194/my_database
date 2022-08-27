import 'package:flutter/material.dart';
import 'package:my_database/themes.dart';

class InputText extends StatelessWidget {
  const InputText({Key? key, required this.label, this.controller, this.hidePassword, this.enable, this.textInputType}) : super(key: key);

  final String label;
  final bool? hidePassword;
  final TextEditingController? controller;
  final bool? enable;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  controller: controller,
                  obscureText: hidePassword ?? false,
                  decoration: InputDecoration.collapsed(hintText: label),
                  cursorColor: Themes().theme.primaryColor,
                  enabled: enable ?? true,
                  keyboardType: textInputType,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
