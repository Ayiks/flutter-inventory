import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_1/controllers/product_controller.dart';
import 'package:inventory_1/views/SalesPerson/confirm_order.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../provider/data/items.dart';
import '../../provider/helpers/DBhelper.dart';
import '../../provider/managers/cart.provider.dart';
import '../../provider/models/cart.model.dart';
import '../../utils/dimmension.dart';

class Dash extends StatefulWidget {
  const Dash({super.key});

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
  int _count = 0;

  void _incrementCount() {
    setState(() {
      var news = _count++;
    });
  }

  void _decrementCount() {
    setState(() {
      var news = _count--;
    });
  }

  DBHelper dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    void saveData(int index) {
      dbHelper
          .insert(
        Cart(
          id: index,
          productId: index.toString(),
          productName: products[index].name,
          initialPrice: products[index].price,
          productPrice: products[index].price,
          quantity: ValueNotifier(1),
          qntyInstock: products[index].quantity,
          image: products[index].image,
        ),
      )
          .then((value) {
        cart.addTotalPrice(products[index].price.toDouble());
        cart.addCounter();
        print('Product Added to cart');
      }).onError((error, stackTrace) {
        print(error.toString());
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Product List'),
        actions: [
          Badge(
            badgeContent: Consumer<CartProvider>(
              builder: (context, value, child) {
                return Text(
                  value.getCounter().toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              },
            ),
            position: const BadgePosition(start: 30, bottom: 30),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConfirmOrder()));
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          shrinkWrap: true,
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.blueGrey.shade200,
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Image(
                    //   height: 80,
                    //   width: 80,
                    //   image: AssetImage(products[index].image.toString()),
                    // ),
                    SizedBox(
                      width: 130,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5.0,
                          ),
                          RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            text: TextSpan(
                                text: 'Name: ',
                                style: TextStyle(
                                    color: Colors.blueGrey.shade800,
                                    fontSize: 16.0),
                                children: [
                                  TextSpan(
                                      text:
                                          '${products[index].name.toString()}\n',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ]),
                          ),
                          RichText(
                            maxLines: 1,
                            text: TextSpan(
                                text: 'Unit: ',
                                style: TextStyle(
                                    color: Colors.blueGrey.shade800,
                                    fontSize: 16.0),
                                children: [
                                  TextSpan(
                                      text:
                                          '${products[index].quantity.toString()}\n',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ]),
                          ),
                          RichText(
                            maxLines: 1,
                            text: TextSpan(
                                text: 'Price: ' r"$",
                                style: TextStyle(
                                    color: Colors.blueGrey.shade800,
                                    fontSize: 16.0),
                                children: [
                                  TextSpan(
                                      text:
                                          '${products[index].price.toString()}\n',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ]),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blueGrey.shade900),
                        onPressed: () {
                          saveData(index);
                        },
                        child: const Text('Add to Cart')),
                  ],
                ),
              ),
            );
          }),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Dimensions.height20, horizontal: Dimensions.width30),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return ConfirmOrder();
            }));
          },
          child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 13, 71, 118),
                  borderRadius: BorderRadius.circular(Dimensions.radius15 - 5)),
              height: Dimensions.height20 * 3,
              width: Dimensions.width30,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Dimensions.height20,
                    horizontal: Dimensions.width20),
                child: Text(
                  'CONFIRM ORDER 2 ITEM(S) GHC 30.50',
                  style: TextStyle(
                      fontSize: Dimensions.font16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              )),
        ),
      ),
    );
  }
}
