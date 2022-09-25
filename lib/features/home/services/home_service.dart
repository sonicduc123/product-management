import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:management_product/features/manage_product/models/product_model.dart';
import 'package:management_product/features/home/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeService {
  static Future<UserModel> getUserInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String userId = sharedPreferences.getString('userId') ?? '';
    log(userId);

    final docUser = FirebaseFirestore.instance.collection('users').doc(userId);
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return UserModel.fromJson(snapshot.data()!);
    }
    return UserModel();
  }

  static Future<List<ProductModel>> getListProduct() async {
    final streamListProduct = FirebaseFirestore.instance
        .collection('products')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ProductModel.fromJson(doc.data()))
            .toList());

    return await streamListProduct.first;
  }
}
