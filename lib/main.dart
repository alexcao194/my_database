
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_database/bloc/data_bloc/data_bloc.dart';
import 'package:my_database/bloc/date_picker_bloc/date_picker_bloc.dart';
import 'package:my_database/bloc/home_page_bloc/home_page_bloc.dart';
import 'package:my_database/bloc/login_bloc/user_bloc.dart';
import 'package:my_database/firebase_options.dart';
import 'package:my_database/ui/screens/splash_screen/splash_screen.dart';

void main() async {
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent
  // ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider<UserBloc>(create: (context) => UserBloc()),
          BlocProvider<HomePageBloc>(create: (context) => HomePageBloc()),
          BlocProvider<DatePickerBloc>(create: (context) => DatePickerBloc()),
          BlocProvider<DataBloc>(create: (context) => DataBloc())
        ],
        child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
