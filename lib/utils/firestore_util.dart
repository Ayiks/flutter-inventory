import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_1/models/product.dart';

class FirestoreUtil {
  static const String productCollection = 'products';
  static const String cartCollection = 'cart';

  static Future<List<Product>> getProducts(List<String>? ids) async {
    try {
      final producRef = FirebaseFirestore.instance
          .collection(productCollection)
          .withConverter<Product>(
              fromFirestore: (snapshot, _) =>
                  Product.fromJson(snapshot.data()!),
              toFirestore: (product, _) => product.toJson());
      QuerySnapshot<Product> productDoc;
      if (ids != null && ids.isNotEmpty) {
        productDoc = await producRef.where('id', whereIn: ids).get();
      } else {
        productDoc = await producRef.get();
      }
      return productDoc.docs.map((e) => e.data()).toList();
    } on FirebaseException catch (e, staktrace) {
      log('Error getting products', stackTrace: staktrace, error: e);
    }
    return [];
  }

  static addToCart(User? user, String productId) async {
    if (user == null) return;
    try {
      DocumentReference<Map<String, dynamic>> product = FirebaseFirestore
          .instance
          .collection('user')
          .doc(user.uid)
          .collection(cartCollection)
          .doc(productId);
      if ((await product.get()).exists) {
        product.set({"count": FieldValue.increment(1)});
      } else {
        product.set({"id": productId, "count": 1});
      }
    } on FirebaseException catch (e, stackTrace) {
      log("Error adding to cart ", stackTrace: stackTrace, error: e);
    }
  }
}
