import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_1/managers/cart_repo.dart';
import 'package:inventory_1/models/cart_model.dart';
import 'package:inventory_1/models/product.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;
  List<CartModel> storageItems = [];

  void addItem(Product product, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(product.productId)) {
      _items.update(product.productId!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            quantity: value.quantity,
            isExit: true,
            time: DateTime.now().toString(),
            product: product);
      });
      if (totalQuantity < 0) {
        _items.remove(product.productId);
      }
    } else {
      if (quantity >= 0) {
        _items.putIfAbsent(product.productId!, () {
          return CartModel(
              id: product.productId,
              name: product.name,
              price: product.price,
              quantity: product.quantity,
              isExit: true,
              time: DateTime.now().toString(),
              product: product);
        });
      } else {
        Get.snackbar('Item Count', 'Add at least 1 item',
            backgroundColor: Colors.blue, colorText: Colors.white);
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(Product product) {
    if (_items.containsKey(product.productId)) {
      return true;
    }
    return false;
  }

  int getQuantity(Product product) {
    var quantity = 0;
    if (_items.containsKey(product.productId)) {
      _items.forEach((key, value) {
        if (key == product.productId) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(
          storageItems[i].product!.productId!, () => storageItems[i]);
    }
  }

  void addToHistory() {
    cartRepo.addToCartHistory();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }
}
