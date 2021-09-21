abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppRegisterSuccessState extends AppStates {}

class AppRegisterErrorState extends AppStates {
  final String error;

  AppRegisterErrorState(this.error);
}

class AppLoginSuccessState extends AppStates {}

class AppLoginErrorState extends AppStates {
  final String error;

  AppLoginErrorState(this.error);
}

class AppCreatUserSuccessState extends AppStates {}

class AppCreatUserErrorState extends AppStates {
  final String error;

  AppCreatUserErrorState(this.error);
}

class AppGetUserDataSuccessState extends AppStates {}

class AppGetUserDataErrorState extends AppStates {
  final String error;

  AppGetUserDataErrorState(this.error);
}

class AppProfileImagePickedSuccessState extends AppStates {}

class AppProfileImagePickedErrorState extends AppStates {}

class AppUploadProfileImageSuccessState extends AppStates {}

class AppUploadProfileImageErrorState extends AppStates {
  final String error;

  AppUploadProfileImageErrorState(this.error);
}

class AppUpdateUserDataSuccessState extends AppStates {}

class AppUpdateUserDataErrorState extends AppStates {
  final String error;

  AppUpdateUserDataErrorState(this.error);
}

class AppSignOutSuccessState extends AppStates {}

class AppSignOutErrorState extends AppStates {
  final String error;

  AppSignOutErrorState(this.error);
}

class AppGetProductsDataSuccessState extends AppStates {}

class AppGetProductsDataErrorState extends AppStates {
  final String error;

  AppGetProductsDataErrorState(this.error);
}
