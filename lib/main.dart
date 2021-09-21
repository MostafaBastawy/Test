import 'package:firebase_core/firebase_core.dart';
import 'package:firebasetestapp/cubit/bloc_observing.dart';
import 'package:firebasetestapp/cubit/cubit.dart';
import 'package:firebasetestapp/cubit/states.dart';
import 'package:firebasetestapp/screens/home_screen.dart';
import 'package:firebasetestapp/screens/login_screen.dart';
import 'package:firebasetestapp/shared/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  String uId = CacheHelper.getData(key: 'uId') ?? '';
  Widget startScreen;
  if (uId.isNotEmpty) {
    startScreen = HomeScreen();
  } else {
    startScreen = LoginScreen();
  }
  runApp(MyApp(
    startScreen: startScreen,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startScreen;

  MyApp({this.startScreen});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getProducts(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            home: startScreen,
          );
        },
      ),
    );
  }
}
