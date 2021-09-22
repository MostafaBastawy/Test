import 'package:firebasetestapp/screens/login_screen.dart';
import 'package:firebasetestapp/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebasetestapp/cubit/cubit.dart';
import 'package:firebasetestapp/cubit/states.dart';
import 'package:easy_localization/easy_localization.dart';
import '../translations/locale_keys.g.dart';

class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {
        if (state is AppRegisterSuccessState) {
          navigateAndFinish(context, LoginScreen());
        }
      },
      builder: (BuildContext context, Object? state) {
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              LocaleKeys.appName.tr(),
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.registerMessage.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07),
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
                        onChanged: (value) {},
                        onFieldSubmitted: (value) {},
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return LocaleKeys.emailVerify.tr();
                          }
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: LocaleKeys.emailLabel.tr(),
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                        onTap: () {},
                        onChanged: (value) {},
                        onFieldSubmitted: (value) {},
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return LocaleKeys.passwordVerify.tr();
                          }
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: LocaleKeys.passwordLabel.tr(),
                          prefixIcon: const Icon(Icons.lock_outline),
                        ),
                        onTap: () {},
                        onChanged: (value) {},
                        onFieldSubmitted: (value) {},
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
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
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            cubit.userRegister(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                        text: LocaleKeys.registerButton.tr(),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.alreadyHaveAnAccount.tr(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                              color: Colors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              navigateTo(
                                  context: context, widget: LoginScreen());
                            },
                            child: Text(LocaleKeys.loginButton.tr()),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
