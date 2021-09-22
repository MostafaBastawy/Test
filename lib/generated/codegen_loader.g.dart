// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar = {
  "products": "المنتجات",
  "appName": "اسم التطبيق",
  "loginMessage": "الرجاء تسجيل الدخول للاستمتاع بعروضنا المميزه",
  "emailVerify": "برجاء التحقق من البريد الالكتروني",
  "emailLabel": "البريد الالكتروني",
  "passwordVerify": "برجاء التحقق من كلمه المرور",
  "passwordLabel": "كلمه المرور",
  "loginButton": "تسجيل الدخول",
  "loginDontHaveAnAccount": "هل لا تمتلك حساب ؟",
  "registerButton": "التسجيل",
  "registerMessage": "الرجاء التسجيل للاستمتاع بعروضنا الساخنة",
  "nameVerify": "برجاء التحقق من الاسم",
  "nameLabel": "الاسم",
  "phoneVerify": "برحاء التحقق من رقم التليفون",
  "phoneLabel": "رقم التليفون",
  "alreadyHaveAnAccount": "هل لديك حساب ؟",
  "profile": "الصفحه الشخصية",
  "update": "تحديث",
  "logout": "تسجيل الخروج"
};
static const Map<String,dynamic> en = {
  "products": "Products",
  "appName": "App Name",
  "loginMessage": "please login to enjoy our hot offers",
  "emailVerify": "email address cant be empty",
  "emailLabel": "Email Address",
  "passwordVerify": "password is too short",
  "passwordLabel": "Password",
  "loginButton": "LOGIN",
  "loginDontHaveAnAccount": "Don\\'t have an account?",
  "registerButton": "REGISTER",
  "registerMessage": "please register to enjoy our hot offers",
  "nameVerify": "name cant be empty",
  "nameLabel": "Full Name",
  "phoneVerify": "phone number cant be empty",
  "phoneLabel": "Phone Number",
  "alreadyHaveAnAccount": "already have an account?",
  "profile": "Profile",
  "update": "UPDATE",
  "logout": "LOGOUT"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": ar, "en": en};
}
