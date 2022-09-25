import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:management_product/features/manage_product/models/product_model.dart';

class ProductService {
  static Future<ProductModel> createProduct(ProductModel product) async {
    final docProduct = FirebaseFirestore.instance.collection('products').doc();

    final json = product.toJson();
    json['id'] = docProduct.id;
    product.id = docProduct.id;

    await docProduct.set(json);

    // upload image

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    var ref = firebaseStorage.ref();
    log("file length: " + product.file.length.toString());

    for (int i = 0; i < product.file.length; i++) {
      var snapshot = await ref
          .child('product-images/${product.id}/$i')
          .putFile(product.file[i]);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      log(downloadUrl);
      product.image!.add(downloadUrl);
    }

    await updateProduct(product);

    return product;
  }

  static updateProduct(ProductModel newProduct) async {
    final docProduct =
        FirebaseFirestore.instance.collection('products').doc(newProduct.id);

    // upload image

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    var ref = firebaseStorage.ref();

    log("file length: " + newProduct.file.length.toString());

    for (int i = 0; i < newProduct.file.length; i++) {
      var snapshot = await ref
          .child(
              'product-images/${newProduct.id}/${i + newProduct.image!.length}')
          .putFile(newProduct.file[i]);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      log(downloadUrl);
      newProduct.image!.add(downloadUrl);
    }

    docProduct.update(newProduct.toJson());
  }

  static deleteProduct(String productId, int numberImage) async {
    // delete image
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    for (int i = 0; i < numberImage; i++) {
      final ref = firebaseStorage.ref().child('product-images/$productId/$i');
      try {
        await ref.delete();
        log(productId);
      } on FirebaseException catch (e) {
        log(e.toString());
      }
    }

    final docProduct =
        FirebaseFirestore.instance.collection('products').doc(productId);

    docProduct.delete();
  }
}
