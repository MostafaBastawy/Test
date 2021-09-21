import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetestapp/screens/home_screen.dart';
import 'package:firebasetestapp/screens/register_screen.dart';
import 'package:firebasetestapp/shared/cache_helper.dart';
import 'package:firebasetestapp/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebasetestapp/cubit/cubit.dart';
import 'package:firebasetestapp/cubit/states.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {
        if (state is AppLoginSuccessState) {
          CacheHelper.sharedPreferences!
              .setString('uId', FirebaseAuth.instance.currentUser!.uid);
          navigateAndFinish(context, const HomeScreen());
        }
      },
      builder: (BuildContext context, Object? state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Test App',
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
                        'please login to enjoy our hot offers',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'email address cant be empty';
                          }
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email Address',
                          prefixIcon: Icon(Icons.email_outlined),
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
                            return 'password is too short';
                          }
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline),
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
                            cubit.userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        text: 'LOGIN',
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                              color: Colors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              navigateTo(
                                  context: context, widget: RegisterScreen());
                            },
                            child: const Text('REGISTER'),
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
