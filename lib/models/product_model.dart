import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? name;
  String? price;
  String? image;

  ProductModel(this.name, this.price, this.image);

  ProductModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    image = json['image'];
  }
}
