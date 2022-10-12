import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_1/controllers/product_controller.dart';
import 'package:inventory_1/views/SalesPerson/confirm_order.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(fontSize: Dimensions.font26 - 2),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<ProductController>(builder: (product) {
        print(product.productList.length);
        return ListView.separated(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width10, vertical: Dimensions.height10),
            itemBuilder: (context, index) {
              var products = product.productList[index];
              return GestureDetector(
                onTap: () {
                  showBarModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(builder: ((context, setState) {
                          return Container(
                              height: Dimensions.height30 * 8,
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.width20,
                                    vertical: Dimensions.height20),
                                child: Column(
                                  children: [
                                    Container(
                                      height: Dimensions.height20 * 4,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: Dimensions.width10 /
                                                      10))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Chicken Thigh',
                                            style: TextStyle(
                                                fontSize: Dimensions.font16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '$_count',
                                                style: TextStyle(
                                                    fontSize: Dimensions.font16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: Dimensions.width10,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.black12,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                    .radius15 -
                                                                5)),
                                                child: Row(
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons.remove,
                                                        size: Dimensions
                                                            .iconSize24,
                                                      ),
                                                      onPressed: () =>
                                                          setState(() {
                                                        _count--;
                                                      }),
                                                    ),
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons.add,
                                                        size: Dimensions
                                                            .iconSize24,
                                                      ),
                                                      onPressed: () =>
                                                          setState(() {
                                                        _count++;
                                                      }),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    Container(
                                      height: Dimensions.height20 * 4,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: Dimensions.width10 /
                                                      10))),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: Dimensions.height20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Total',
                                                  style: TextStyle(
                                                      fontSize:
                                                          Dimensions.font16),
                                                ),
                                                SizedBox(
                                                  width: Dimensions.width10,
                                                ),
                                                Text(
                                                  'GHC 20',
                                                  style: TextStyle(
                                                      fontSize:
                                                          Dimensions.font16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: Dimensions.height20 * 2,
                                              width: Dimensions.width30 * 5,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.radius15 -
                                                              5)),
                                              child: Center(
                                                child: Text(
                                                  'ADD TO ORDER',
                                                  style: TextStyle(
                                                      fontSize:
                                                          Dimensions.font16,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ));
                        }));
                      });
                },
                child: Container(
                  height: Dimensions.height20 * 4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: Dimensions.width10 / 10,
                              color: Colors.grey))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Chicken',
                          style: TextStyle(
                              fontSize: Dimensions.font16,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'GHC 20',
                          style: TextStyle(
                              fontSize: Dimensions.font16,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext int, index) {
              return Divider(
                height: Dimensions.height10,
              );
            },
            itemCount: product.productList.length);
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
