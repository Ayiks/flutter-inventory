import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/product.dart';

class ProductManager with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  final CollectionReference<Map<String, dynamic>> _productCollection =
      _firebaseFirestore.collection("products");
  final CollectionReference<Map<String, dynamic>> _transactionCollection =
      _firebaseFirestore.collection("transaction");

  String _message = '';
  bool _isLoading = false;
  String get message => _message;
  bool get isLoading => _isLoading;

  setMessage(String message) {
    _message = message;
    notifyListeners();
  }

  setIsLoading(bool loading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  //CREATE PRODUCT
  Future<bool> addProduct(Product product) async {
    bool result = false;
    setIsLoading(true);

    await _productCollection.doc().set({
      "name": product.name,
      "type": product.type,
      "price": product.price,
      "quantity": product.quantity,
      "lowOnStock": product.lowOnStock,
      "productId": product.productId,
      "createdAt": FieldValue.serverTimestamp()
    }).then((_) {
      result = true;
      setMessage('Product added successfully');
    }).catchError((onError) {
      setMessage('#####' + onError.toString());
      result = false;
      setIsLoading(false);
    }).timeout(const Duration(seconds: 10), onTimeout: () {
      setMessage('Timeout');
      setIsLoading(false);
    });
    return result;
  }

  //READ ALL PRODUCTS
  Stream<QuerySnapshot<Map<String, dynamic>?>> getAllProducts() {
    return _productCollection.snapshots();
  }

  // Future<QuerySnapshot<Map<String, dynamic>>> getTotal() {

  //   return _productCollection.get().then((value) {
  //     return value;
  //   });
  // }

  //READ SINGLE PRODUCT
  Stream<DocumentSnapshot<Map<String, dynamic>>> getProduct(
      {required String docID}) {
    return _productCollection.doc(docID).snapshots();
  }

  //READ  LOW ON STOCK
  Stream<QuerySnapshot<Map<String, dynamic>>> getLowStock(
      {required int lowInStock}) {
    return _productCollection
        .where('quantity', isLessThanOrEqualTo: lowInStock)
        .snapshots();
  }

  //OUT OF STOCK
  Stream<QuerySnapshot<Map<String, dynamic>>> getOutOfStock() {
    return _productCollection.where('quantity', isEqualTo: 0).snapshots();
  }

//READ PRODUCTS BASED ON STOCK
  Stream<QuerySnapshot<Map<String, dynamic>?>> getStock(int? value) {
    return _productCollection
        .where("quantity", isLessThanOrEqualTo: value)
        .snapshots();
  }

  //READ PRODUCTS BASED ON STOCK
  Stream<QuerySnapshot<Map<String, dynamic>?>> getRecent() {
    return _productCollection
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

//UPDATE PRODUCT
  Future<bool> updateProduct(
      {required String docID, double? price, int? quantity}) async {
    Map<String, dynamic> data = <String, dynamic>{
      "price": price,
      "quantity": quantity
    };
    bool isUpdated = false;
    await _productCollection.doc(docID).update(data).then((value) {
      isUpdated = true;
      return value;
    }).catchError((onError) {
      setMessage(onError);
      setIsLoading(false);
      isUpdated = false;
    }).timeout(const Duration(seconds: 60), onTimeout: (() {
      setMessage("Check your internet connection");
      isUpdated = false;
    }));

    return isUpdated;
  }

  //DELETE ROOMS
  Future<bool> deletedProduct({required String docId}) async {
    bool isDeleted = false;
    await _productCollection.doc(docId).delete().then((value) {
      isDeleted = true;
      setMessage("Product deleted succefully");
    }).catchError((onError) {
      setMessage("Failed to delete product: $onError");
      setIsLoading(false);
      isDeleted = false;
    });
    return isDeleted;
  }
}
