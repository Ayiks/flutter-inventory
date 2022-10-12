import 'package:get/get.dart';
import 'package:inventory_1/controllers/cart_controller.dart';
import 'package:inventory_1/controllers/product_controller.dart';
import 'package:inventory_1/managers/cart_repo.dart';
import 'package:inventory_1/managers/product_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  //load repository

  Get.lazyPut(() => CartRepo());
  Get.lazyPut(() => ProductManager());

  //load controllers
  Get.lazyPut(() => ProductController(productManager: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
