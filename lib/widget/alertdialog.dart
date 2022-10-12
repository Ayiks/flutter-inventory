import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_1/item_specific.dart';
import 'package:inventory_1/managers/product_manager.dart';
import 'package:inventory_1/utils/dimmension.dart';

class alertdialog extends StatelessWidget {
  String text;
  String text1;
  IconData icon;
  IconData icon1;
  String docId;
  alertdialog(
      {Key? key,
      required this.text,
      required this.icon,
      required this.text1,
      required this.icon1,
      required this.docId})
      : super(key: key);

  final ProductManager _productManager = ProductManager();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 30,
      content: Container(
        height: Dimensions.height20 * 5,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ItemSpecific(
                    docId: docId,
                  );
                }));
              },
              child: Container(
                height: Dimensions.height20 * 2,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius15 - 5)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.height10,
                      horizontal: Dimensions.width10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        text,
                        style: TextStyle(
                            fontSize: Dimensions.font16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 22, 90, 145)),
                      ),
                      Icon(
                        icon,
                        size: Dimensions.iconSize24,
                        color: Color.fromARGB(225, 22, 90, 145),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            GestureDetector(
              onTap: () async {
                showDialog(
                    context: context,
                    builder: ((context) {
                      return AlertDialog(
                        title: const Icon(Icons.warning_amber_rounded,
                            color: Colors.red),
                        content:
                            Text('Are you sure you want to delete product?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('No')),
                          TextButton(
                              onPressed: () async {
                                bool isDeleted = await _productManager
                                    .deletedProduct(docId: docId);
                                if (isDeleted) {
                                  Navigator.pop(context);
                                  Fluttertoast.showToast(
                                      msg: "Product Deleted",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: _productManager.message,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              },
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: Dimensions.font16),
                              ))
                        ],
                      );
                    }));
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        text1,
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        icon1,
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
