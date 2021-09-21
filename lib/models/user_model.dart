class UserDataModel {
  String? name;
  String? email;
  String? phone;
  String? profileImageUrl;

  UserDataModel(
    this.name,
    this.email,
    this.phone,
    this.profileImageUrl,
  );

  UserDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    profileImageUrl = json['profileImageUrl'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'profileImageUrl': profileImageUrl,
    };
  }
}
