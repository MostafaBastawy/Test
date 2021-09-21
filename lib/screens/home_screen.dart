import 'package:firebasetestapp/cubit/cubit.dart';
import 'package:firebasetestapp/cubit/states.dart';
import 'package:firebasetestapp/models/product_model.dart';
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
          body: ListView.separated(
            itemBuilder: (BuildContext context, int index) =>
                itemBuilder(context, cubit.products[index]),
            separatorBuilder: (BuildContext context, int index) => Container(
              height: 1.0,
              width: double.infinity,
            ),
            itemCount: cubit.products.length,
          ),
        );
      },
    );
  }

  Widget itemBuilder(BuildContext context, ProductModel model) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(model.image!),
                height: 200.0,
                width: 150.0,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 10.0),
                child: Container(
                  height: 200.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name!,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .01),
                      Text(
                        '${model.price} USD',
                        style: const TextStyle(
                          fontSize: 25.0,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
