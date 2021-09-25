import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasetestapp/cubit/bloc_observing.dart';
import 'package:firebasetestapp/cubit/cubit.dart';
import 'package:firebasetestapp/cubit/states.dart';
import 'package:firebasetestapp/screens/home_screen.dart';
import 'package:firebasetestapp/screens/login_screen.dart';
import 'package:firebasetestapp/shared/cache_helper.dart';
import 'package:firebasetestapp/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'generated/codegen_loader.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  String uId = CacheHelper.getData(key: 'uId') ?? '';
  language = CacheHelper.getData(key: 'language') ?? 'products';

  Widget startScreen;
  if (uId.isNotEmpty) {
    startScreen = HomeScreen();
  } else {
    startScreen = LoginScreen();
  }

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path:
          'assets/translations', // <-- change the path of the translation files
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
      child: MyApp(
        startScreen: startScreen,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget? startScreen;

  MyApp({this.startScreen});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          AppCubit()..getProducts(productLanguage: language),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          print(context.locale.languageCode);
          AppCubit cubit = AppCubit.get(context);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: startScreen,
          );
        },
      ),
    );
  }
}
