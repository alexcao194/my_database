import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_database/strings.dart';
import 'package:my_database/themes.dart';

class Header extends StatelessWidget {
  const Header({Key? key, required this.user}) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Xin chào,',
                style: TextStyle(
                    fontFamily: Themes().headerFont1,
                    fontSize: 16
                )
            ),
            const SizedBox(height: 4.0),
            Text(
                user!.displayName ?? '',
                style: TextStyle(
                    fontFamily: Themes().headerFont2,
                    fontSize: 26
                )
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: 50,
            width: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                user!.photoURL ?? Strings().defaultAvatar,
                fit: BoxFit.fitHeight,
              )
            ),
          ),
        )
      ],
    );
  }
}
