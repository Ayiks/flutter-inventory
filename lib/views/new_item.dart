import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:inventory_1/managers/product_manager.dart';
import 'package:inventory_1/models/product.dart';
import 'package:inventory_1/utils/dimmension.dart';

import 'dashboard.dart';

class NewItem extends StatefulWidget {
  NewItem({Key? key}) : super(key: key);

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  String dropdownValueItem = 'Select option';
  String dropdownValueType = 'Select option';
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _lowStockController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final ProductManager _productManager = ProductManager();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isLoading = false;

  List<String> chickenData = [
    'Select option',
    'Legs',
    'wings',
    'Gizzard',
  ];
  List<String> fishData = [
    'Select option',
    'Salmon',
    'Kpanla',
    'Tuna',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Item',
          style: TextStyle(color: Colors.black, fontSize: Dimensions.font20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Dimensions.height20, horizontal: Dimensions.width10),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  height: Dimensions.height20 * 4,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.width30, right: Dimensions.width30),
                    child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            labelText: 'Items',
                            labelStyle: TextStyle(
                                fontSize: Dimensions.font20,
                                fontWeight: FontWeight.w600),
                            prefixIcon: Icon(
                              Icons.type_specimen,
                              color: Colors.red,
                              size: Dimensions.iconSize24,
                            )),
                        dropdownColor: Colors.white,
                        validator: (value) {
                          if (value == 'Select option') {
                            return 'Please select an option';
                          }
                          return null;
                        },
                        value: dropdownValueItem,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          size: Dimensions.iconSize24,
                        ),
                        elevation: 16,
                        style: TextStyle(
                            color: Colors.black, fontSize: Dimensions.font20),
                        items: <String>[
                          'Select option',
                          'Meat',
                          'Fish',
                          'chicken',
                          'Sausage',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                  fontSize: Dimensions.font16,
                                  fontWeight: FontWeight.w500),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValueItem = newValue!;
                          });
                        }),
                  ),
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  height: Dimensions.height20 * 4,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.width30, right: Dimensions.width30),
                    child: DropdownButtonFormField(
                        dropdownColor: Colors.white,
                        decoration: InputDecoration(
                            labelText: 'Types',
                            labelStyle: TextStyle(
                                fontSize: Dimensions.font26 - 2,
                                fontWeight: FontWeight.w500),
                            prefixIcon: Icon(
                              Icons.type_specimen,
                              color: Colors.red,
                              size: Dimensions.iconSize24,
                            )),
                        validator: (value) {
                          if (value == 'Select option') {
                            return 'Please select an option';
                          }
                          return null;
                        },
                        value: dropdownValueType,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          size: Dimensions.iconSize24,
                        ),
                        elevation: 16,
                        style: TextStyle(
                            color: Colors.black, fontSize: Dimensions.font20),
                        items: dropdownValueItem == "Fish"
                            ? fishData
                                .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                );
                              }).toList()
                            : dropdownValueItem == "chicken"
                                ? chickenData.map<DropdownMenuItem<String>>(
                                    (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                            fontSize: Dimensions.font16),
                                      ),
                                    );
                                  }).toList()
                                : null,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValueType = newValue!;
                          });
                        }),
                  ),
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width30),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.black26,
                                width: Dimensions.width10 / 10))),
                    height: Dimensions.height20 * 4,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.only(left: Dimensions.width10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.monetization_on,
                                color: Colors.green,
                                size: Dimensions.iconSize24,
                              )
                            ],
                          ),
                          Expanded(
                            child: TextFormField(
                                controller: _priceController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    labelText: 'Price',
                                    prefix: Text('GHC    '),
                                    labelStyle: TextStyle(
                                        fontSize: Dimensions.font16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    hintStyle:
                                        TextStyle(fontSize: Dimensions.font16),
                                    hintText: 'Enter price of product')),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width30),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: Dimensions.width10 / 10))),
                    height: Dimensions.height20 * 4,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.only(left: Dimensions.width10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.monitor_weight_rounded,
                                color: Color.fromARGB(255, 12, 4, 154),
                                size: Dimensions.iconSize24,
                              )
                            ],
                          ),
                          Expanded(
                            child: TextFormField(
                                controller: _quantityController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    labelText: 'Quantity',
                                    prefix: const Text('Kilogram(s)    '),
                                    labelStyle: TextStyle(
                                        fontSize: Dimensions.font16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    hintStyle:
                                        TextStyle(fontSize: Dimensions.font16),
                                    hintText: '10')),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width30),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: Dimensions.width10 / 10))),
                    height: Dimensions.height20 * 4,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.only(left: Dimensions.width10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.warning_amber_rounded,
                                color: Color.fromARGB(255, 236, 215, 25),
                                size: Dimensions.iconSize24,
                              )
                            ],
                          ),
                          Expanded(
                            child: TextFormField(
                                controller: _lowStockController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    labelText: 'Low Stock',
                                    prefix: Text('Kilogram(s)    '),
                                    labelStyle: TextStyle(
                                        fontSize: Dimensions.font16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    hintStyle:
                                        TextStyle(fontSize: Dimensions.font16),
                                    hintText: '20')),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.height45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: Dimensions.height10 * 5,
                      width: Dimensions.width20 * 5,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20 / 2),
                          color: Colors.red),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 15),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensions.font16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        addItem();
                      },
                      child: Container(
                        height: Dimensions.height10 * 5,
                        width: Dimensions.width20 * 5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 9, 82, 142)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 30, top: 15),
                          child: Text(
                            'Save',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.font16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addItem() async {
    bool isCreated = await _productManager.addProduct(Product(
        name: dropdownValueItem.toString(),
        type: dropdownValueType.toString(),
        price: double.parse(_priceController.text),
        quantity: int.parse(_quantityController.text),
        productId: generateProductId(),
        lowOnStock: int.parse(_lowStockController.text)));

    if (isCreated) {
      Get.to(() => Dashboard());
      Fluttertoast.showToast(
          msg: "Product Added Successfully",
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
  }

  int generateProductId() {
    var random = Random();
    var randomNumber = random.nextInt(1000000);
    return randomNumber;
  }
}
