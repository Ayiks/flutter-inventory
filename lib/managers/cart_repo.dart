import 'dart:convert';

import 'package:inventory_1/models/cart_model.dart';

class CartRepo {
  CartRepo();

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    var time = DateTime.now().toString();
    cart = [];

    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });
  }

  List<CartModel> getCartList() {
    List<String> carts = [];

    List<CartModel> cartList = [];
    cart.forEach((element) =>
        cartList.add(CartModel.fromJson(jsonDecode(element))));
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) => cartListHistory
        .add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  void addToCartHistory() {
    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
    }

    removeCart();
  }

  void removeCart() {
    cart = [];
  }
}
