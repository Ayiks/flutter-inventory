import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_1/controllers/cart_controller.dart';
import 'package:inventory_1/managers/product_manager.dart';
import 'package:inventory_1/models/cart_model.dart';
import 'package:inventory_1/models/product.dart';

class ProductController extends GetxController {
  final ProductManager productManager;
  ProductController({required this.productManager});

  List<dynamic> _productsList = [];
  List<dynamic> get productList => _productsList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItem = 0;
  int get inCartItem => _inCartItem;

  Future<List<Product>> getProductList() async {
    try {
      final productRef = FirebaseFirestore.instance
          .collection("products")
          .withConverter<Product>(
              fromFirestore: (snapshot, _) =>
                  Product.fromJson(snapshot.data()!),
              toFirestore: (product, _) => product.toJson());
      QuerySnapshot<Product> productDoc;

      productDoc = await productRef.get();

      // _productsList = productDoc.docs.map((e) => e.data()).toList();

      // productDoc.docs.map((e) {
      //   _productsList = [];
      //   _productsList = e.data() as List;
      //   // _productsList.addAll(ProductModel.fromJson(e.data()).products);
      // });
    } catch (e) {
      print(e);
    }
    return [];
  }

  static Future<List<Product>> getProducts(List<String>? ids) async {
    try {
      final producRef = FirebaseFirestore.instance
          .collection("products")
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

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      print(_quantity);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItem + quantity) < 0) {
      Get.snackbar("Product Count", "Can't be below zero",
          backgroundColor: Colors.blue, colorText: Colors.white);
      if (_inCartItem > 0) {
        _quantity = -_inCartItem;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItem + quantity) > 20) {
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(Product product, CartController cart) {
    _quantity = 0;
    _inCartItem = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);

    if (exist) {
      _inCartItem = _cart.getQuantity(product);
    }
  }

  void addItem(Product product) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItem = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      print('the id is ' +
          value.id.toString() +
          " The quantity is " +
          value.quantity.toString());
    });
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
