import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebasetestapp/cubit/states.dart';
import 'package:firebasetestapp/models/product_model.dart';
import 'package:firebasetestapp/models/user_model.dart';
import 'package:firebasetestapp/shared/cache_helper.dart';
import 'package:firebasetestapp/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  UserDataModel? userModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      creatUser(
        name: name,
        email: email,
        phone: phone,
      );
      emit(AppRegisterSuccessState());
    }).catchError((error) {
      emit(AppRegisterErrorState(error.toString()));
    });
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(AppLoginSuccessState());
    }).catchError((error) {
      emit(AppLoginErrorState(error.toString()));
    });
  }

  void creatUser({
    required String name,
    required String email,
    required String phone,
  }) {
    UserDataModel model = UserDataModel(
      name,
      email,
      phone,
      defaultProfileImageUrl,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(model.toMap())
        .then((value) {
      emit(AppCreatUserSuccessState());
    }).catchError((error) {
      emit(AppCreatUserErrorState(error.toString()));
    });
  }

  void getUserData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      userModel = UserDataModel.fromJson(value.data()!);
      emit(AppGetUserDataSuccessState());
    }).catchError((error) {
      emit(AppGetUserDataErrorState(error.toString()));
    });
  }

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(AppProfileImagePickedSuccessState());
    } else {
      emit(AppProfileImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String email,
    File? profileImageUrl,
  }) {
    if (profileImageUrl != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users')
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child('profileImage.jpg')
          .putFile(profileImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          updateUser(
            name: name,
            email: email,
            phone: phone,
            imageUrl: value,
          );
        }).catchError((error) {
          emit(AppUploadProfileImageErrorState(error.toString()));
        });
      }).catchError((error) {
        emit(AppUploadProfileImageErrorState(error.toString()));
      });
    } else {
      updateUser(
        name: name,
        email: email,
        phone: phone,
        imageUrl: userModel!.profileImageUrl,
      );
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut().then((value) {
      emit(AppSignOutSuccessState());
      CacheHelper.sharedPreferences!.remove('uId');
    }).catchError((error) {
      emit(AppSignOutErrorState(error.toString()));
    });
  }

  void updateUser({
    required String name,
    required String email,
    required String phone,
    String? imageUrl,
  }) {
    UserDataModel model = UserDataModel(
      name,
      email,
      phone,
      imageUrl ?? userModel!.profileImageUrl,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(model.toMap())
        .then((value) {})
        .catchError((error) {
      emit(AppUpdateUserDataErrorState(error.toString()));
    });
  }

  List<ProductModel> products = [];

  void getProducts({
    String productLanguage = 'products',
  }) {
    products = [];
    FirebaseFirestore.instance.collection(productLanguage).get().then((value) {
      value.docs.forEach((element) {
        products.add(ProductModel.fromJson(element.data()));
      });
      emit(AppGetProductsDataSuccessState());
    }).catchError((error) {
      emit(AppGetProductsDataErrorState(error.toString()));
    });
  }
}
