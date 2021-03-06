import 'package:firebasetestapp/cubit/cubit.dart';
import 'package:firebasetestapp/cubit/states.dart';
import 'package:firebasetestapp/models/user_model.dart';
import 'package:firebasetestapp/screens/home_screen.dart';
import 'package:firebasetestapp/screens/login_screen.dart';
import 'package:firebasetestapp/shared/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../translations/locale_keys.g.dart';

class ProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    UserDataModel userModel = cubit.userModel!;
    nameController.text = userModel.name!;
    phoneController.text = userModel.phone!;

    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {
        if (state is AppSignOutSuccessState) {
          navigateAndFinish(context, LoginScreen());
        }
      },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.profile.tr()),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          radius: 100.0,
                          backgroundImage: cubit.profileImage == null
                              ? NetworkImage(
                                  '${cubit.userModel!.profileImageUrl}')
                              : FileImage(cubit.profileImage!) as ImageProvider,
                        ),
                        CircleAvatar(
                          radius: 25.0,
                          backgroundColor: Colors.white,
                          child: InkWell(
                            onTap: () {
                              cubit.getProfileImage();
                            },
                            child: const Icon(
                              Icons.camera_alt,
                              size: 35.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      cubit.userModel!.email.toString(),
                      style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.nameVerify.tr();
                      }
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: LocaleKeys.nameLabel.tr(),
                      prefixIcon: const Icon(Icons.person),
                    ),
                    onTap: () {},
                    onChanged: (String value) {},
                    onFieldSubmitted: (value) {},
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.phoneVerify.tr();
                      }
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: LocaleKeys.phoneLabel.tr(),
                      prefixIcon: const Icon(Icons.phone),
                    ),
                    onTap: () {},
                    onChanged: (value) {},
                    onFieldSubmitted: (value) {},
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  defaultButton(
                    function: () {
                      cubit.uploadProfileImage(
                        name: nameController.text,
                        phone: phoneController.text,
                        email: cubit.userModel!.email!,
                        profileImageUrl: cubit.profileImage,
                      );
                      navigateAndFinish(context, const HomeScreen());
                    },
                    text: LocaleKeys.update.tr(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  defaultButton(
                    function: () {
                      cubit.signOut();
                    },
                    text: LocaleKeys.logout.tr(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
