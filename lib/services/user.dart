import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_tut/helpers/costants.dart';
import 'package:ecommerce_admin_tut/models/user.dart';

class UserServices {
  String adminsCollection = "admins";
  String usersCollection = "users";

  void createAdmin({
    String id,
    String name,
    String email,
  }) {
    firebaseFiretore.collection(adminsCollection).doc(id).set({
      "name": name,
      "id": id,
      "email": email,
    });
  }

  void updateUserData(Map<String, dynamic> values) {
    firebaseFiretore
        .collection(adminsCollection)
        .doc(values['id'])
        .update(values);
  }

}
