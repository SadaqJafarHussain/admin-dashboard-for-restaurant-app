import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const ID="id";
  static const NAME = "name";
  static const PICTURE = "image";
  static const PRICE = "price";
  static const CATID="categoryId";

  String _id;
  String _name;
  String _picture;
  String _price;

  String get id => _id;
  String get name => _name;

  String get picture => _picture;

  String get price => _price;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id=snapshot.documentID;
    _price = snapshot.data()[PRICE];
    _name = snapshot.data()[NAME];
    _picture = snapshot.data()[PICTURE];
  }
}
