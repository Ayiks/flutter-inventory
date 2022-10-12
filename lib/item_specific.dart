import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_1/managers/product_manager.dart';
import 'package:inventory_1/models/product.dart';
import 'package:inventory_1/utils/dimmension.dart';

class ItemSpecific extends StatefulWidget {
  final String docId;
  const ItemSpecific({Key? key, required this.docId}) : super(key: key);

  @override
  State<ItemSpecific> createState() => _ItemSpecificState();
}

class _ItemSpecificState extends State<ItemSpecific> {
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final ProductManager _productManager = ProductManager();
  final GlobalKey<FormState> _globalKey = GlobalKey();
  bool _isLoading = false;
  int _count = 0;

  void _incrementCount() {
    setState(() {
      var news = _count++;
      _quantityController.text = news.toString();
    });
  }

  void _decrementCount() {
    setState(() {
      var news = _count--;
      _quantityController.text = news.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Item Spec',
          style: TextStyle(fontSize: Dimensions.font20),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>?>>(
                  stream: _productManager.getProduct(docID: widget.docId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting &&
                        snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data == null) {
                      return const Center(
                        child: Text("No data"),
                      );
                    }
                    var name = snapshot.data!.data()!['name'];
                    var type = snapshot.data!.data()!['type'];
                    var quantity = snapshot.data!.data()!['quantity'];
                    var price = snapshot.data!.data()!['price'];
                    _priceController.text = price.toString();

                    return Form(
                      key: _globalKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: Dimensions.height45 + 5,
                                  decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius15 - 5)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.width20,
                                        vertical: Dimensions.height10),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Quantity:',
                                          style: TextStyle(
                                              fontSize: Dimensions.font16),
                                        ),
                                        Text(
                                          ' $quantity',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: Dimensions.font16),
                                        )
                                      ],
                                    ),
                                  )),
                              Container(
                                  height: Dimensions.height45 + 5,
                                  decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.width10,
                                        vertical: Dimensions.height10),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Total Value:',
                                          style: TextStyle(
                                              fontSize: Dimensions.font16),
                                        ),
                                        Text(
                                          ' GHC ${quantity * price}',
                                          style: TextStyle(
                                              fontSize: Dimensions.font16,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.height30,
                          ),
                          Container(
                            height: Dimensions.height20 * 20,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radius15 - 5)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: Dimensions.height45 + 5,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: Dimensions.width10 / 10,
                                              color: Colors.grey))),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: Dimensions.width20 * 4,
                                        left: Dimensions.width20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Product Name:',
                                          style: TextStyle(
                                              fontSize: Dimensions.font16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          '$name $type',
                                          style: TextStyle(
                                              fontSize: Dimensions.font16,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: Dimensions.height45 + 25,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: Dimensions.width10 / 10,
                                              color: Colors.grey))),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: Dimensions.width20 * 4,
                                        left: Dimensions.width20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Quantity in Stock:',
                                          style: TextStyle(
                                              fontSize: Dimensions.font16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          '$quantity',
                                          style: TextStyle(
                                              fontSize: Dimensions.font16,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: Dimensions.height45 + 25,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: Dimensions.width10 / 10,
                                              color: Colors.grey))),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: Dimensions.width20 * 2.5,
                                        left: Dimensions.width20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Price:',
                                          style: TextStyle(
                                              fontSize: Dimensions.font16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        ),
                                        SizedBox(
                                          height: Dimensions.height20 * 3,
                                          width: Dimensions.width20 * 5,
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.never,
                                              prefix: Text(
                                                'GHC  ',
                                                style: TextStyle(
                                                    fontSize:
                                                        Dimensions.font16),
                                              ),
                                              labelStyle: TextStyle(
                                                  fontSize: Dimensions.font16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              hintStyle: TextStyle(
                                                  fontSize: Dimensions.font16),
                                            ),
                                            controller: _priceController,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(
                                                fontSize: Dimensions.font16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: Dimensions.height45 * 4,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: Dimensions.width10,
                                              color: Colors.black))),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.width20,
                                        vertical: Dimensions.height10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Adjust',
                                          style: TextStyle(
                                              fontSize: Dimensions.font16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: Dimensions.height20 * 3,
                                              width: Dimensions.width15 * 10,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never,
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width:
                                                            Dimensions.width10 /
                                                                10,
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  labelText: 'Quantity',
                                                  prefix: Text('kilos    '),
                                                  labelStyle: TextStyle(
                                                      fontSize:
                                                          Dimensions.font16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  hintStyle: TextStyle(
                                                    fontSize: Dimensions.font16,
                                                  ),
                                                ),
                                                controller: _quantityController,
                                                keyboardType:
                                                    TextInputType.number,
                                                style: TextStyle(
                                                    fontSize: Dimensions.font16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Please fill here';
                                                  }
                                                },
                                              ),
                                            ),
                                            Container(
                                                color: Colors.black12,
                                                child: Row(
                                                  children: [
                                                    IconButton(
                                                        onPressed:
                                                            _decrementCount,
                                                        icon: Icon(
                                                          Icons.chevron_left,
                                                          size: Dimensions
                                                              .iconSize24,
                                                        )),
                                                    IconButton(
                                                        onPressed:
                                                            _incrementCount,
                                                        icon: Icon(
                                                          Icons.chevron_right,
                                                          size: Dimensions
                                                              .iconSize24,
                                                        )),
                                                  ],
                                                ))
                                          ],
                                        ),
                                        SizedBox(
                                          height: Dimensions.height10 - 5,
                                        ),
                                        GestureDetector(
                                          onTap: (() async {
                                            if (_globalKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                _isLoading = true;
                                              });

                                              bool
                                                  isUpdated =
                                                  await _productManager
                                                      .updateProduct(
                                                          docID: widget.docId,
                                                          price: double.parse(
                                                              _priceController
                                                                  .text),
                                                          quantity: int.parse(
                                                              _quantityController
                                                                  .text));
                                              if (isUpdated) {
                                                //     Navigator.of(context).pop(isUpdated);
                                                //     Fluttertoast.showToast(
                                                // msg: "Product",
                                                // toastLength: Toast.LENGTH_SHORT,
                                                // gravity: ToastGravity.CENTER,
                                                // timeInSecForIosWeb: 1,
                                                // backgroundColor: Colors.green,
                                                // textColor: Colors.white,
                                                // fontSize: 16.0);

                                                setState(() {
                                                  _isLoading = false;
                                                });

                                                showDialog(
                                                    context: context,
                                                    builder: ((context) =>
                                                        AlertDialog(
                                                          title: const Text(
                                                              "Success"),
                                                          content: const Text(
                                                              "Product Updated successfully"),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    const Text(
                                                                        "Ok"))
                                                          ],
                                                        )));
                                              }
                                            } else {
                                              showDialog(
                                                  context: context,
                                                  builder: ((context) =>
                                                      AlertDialog(
                                                        titleTextStyle:
                                                            const TextStyle(
                                                                color:
                                                                    Colors.red),
                                                        title:
                                                            const Text("Error"),
                                                        content: const Text(
                                                            "Please make the neccessary changes before!"),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  "Ok"))
                                                        ],
                                                      )));
                                            }
                                          }),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 16, 81, 133),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius15 -
                                                            5)),
                                            height: Dimensions.height10 * 5,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Center(
                                                child: Text(
                                              'Save Changes',
                                              style: TextStyle(
                                                  fontSize: Dimensions.font16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
