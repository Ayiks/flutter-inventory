import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_1/managers/product_manager.dart';
import 'package:inventory_1/utils/dimmension.dart';

import '../widget/alertdialog.dart';

class OutOfStock extends StatelessWidget {
  OutOfStock({
    Key? key,
  }) : super(key: key);

  final ProductManager _productManager = ProductManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Low on Stock'),
          centerTitle: true,
        ),
        body: SafeArea(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>?>>(
                stream: _productManager.getOutOfStock(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting &&
                      snapshot.data == null) {
                    const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.data == null) {
                    return const Text("no data available yet");
                  }
                  return ListView.separated(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimensions.height10,
                          horizontal: Dimensions.width10),
                      itemBuilder: ((context, index) {
                        if (snapshot.connectionState ==
                                ConnectionState.waiting &&
                            snapshot.data == null) {
                          const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }
                        var name = snapshot.data!.docs[index].data()!['name'];
                        var type = snapshot.data!.docs[index].data()!['type'];
                        var quantity =
                            snapshot.data!.docs[index].data()!['quantity'];
                        var price = snapshot.data!.docs[index].data()!['price'];
                        var newPrice = price * quantity;
                        var docId = snapshot.data!.docs[index].id;
                        return Container(
                          height: Dimensions.height20 * 5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radius15 - 5),
                              color: Colors.black12),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.height10,
                                horizontal: Dimensions.width10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '$name $type',
                                      style: TextStyle(
                                          fontSize: Dimensions.font16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: Dimensions.height10,
                                    ),
                                    Text('23:40;32'),
                                    SizedBox(
                                      width: Dimensions.height10,
                                    ),
                                    Icon(
                                      Icons.warning_amber_rounded,
                                      size: Dimensions.iconSize24,
                                      color: Colors.yellow,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '$quantity in Stock',
                                      style: TextStyle(
                                          fontSize: Dimensions.font16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'GHC $newPrice',
                                      style: TextStyle(
                                          fontSize: Dimensions.font16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    GestureDetector(
                                        onTap: (() {
                                          showDialog(
                                              barrierColor: Colors.black45,
                                              context: context,
                                              builder: (context) {
                                                return alertdialog(
                                                  docId: docId,
                                                  text: 'Edit Item',
                                                  text1: 'Delete Item',
                                                  icon: Icons.edit_note_rounded,
                                                  icon1: Icons
                                                      .delete_outline_rounded,
                                                );
                                              });
                                        }),
                                        child: Icon(
                                          Icons.more_horiz,
                                          size: Dimensions.iconSize24,
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                      separatorBuilder: ((context, index) => Divider()),
                      itemCount: snapshot.data == null
                          ? 0
                          : snapshot.data!.docs.length);
                })));
  }
}
