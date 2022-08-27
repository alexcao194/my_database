import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_database/themes.dart';
import 'package:my_database/ui/screens/user_screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Alex Database',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w900,
              color: Themes().theme.primaryColor,
            )
        ),
      ),
    );
  }
}
