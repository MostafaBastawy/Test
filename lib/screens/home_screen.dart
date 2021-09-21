import 'package:firebasetestapp/cubit/cubit.dart';
import 'package:firebasetestapp/cubit/states.dart';
import 'package:firebasetestapp/screens/profile_screen.dart';
import 'package:firebasetestapp/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {
        if (state is AppGetUserDataSuccessState) {
          navigateTo(context: context, widget: ProfileScreen());
        }
      },
      builder: (BuildContext context, Object? state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Products'),
            actions: [
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 20.0),
                child: IconButton(
                  onPressed: () {
                    cubit.getUserData();
                  },
                  icon: const Icon(
                    Icons.person_pin,
                    size: 35.0,
                  ),
                ),
              ),
            ],
          ),
          body: const Center(
            child: Text(
              'Products',
            ),
          ),
        );
      },
    );
  }
}
