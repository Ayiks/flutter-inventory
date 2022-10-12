import 'package:flutter/material.dart';
import 'package:inventory_1/utils/dimmension.dart';

class ConfirmOrder extends StatefulWidget {
  const ConfirmOrder({super.key});

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
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
          'Confirmation',
          style: TextStyle(fontSize: Dimensions.font20),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Container(
              height: Dimensions.height20 * 4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: Dimensions.width10 / 10, color: Colors.grey))),
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
                    ),
                    Row(
                      children: [
                        Text(
                          '$_count',
                          style: TextStyle(
                              fontSize: Dimensions.font16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: Dimensions.width10,
                        ),
                        Container(
                          height: Dimensions.height10 * 4,
                          width: Dimensions.width20 * 5,
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radius15 - 5)),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.remove,
                                  size: Dimensions.iconSize16,
                                ),
                                onPressed: () => setState(() {
                                  _count--;
                                }),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.add,
                                  size: Dimensions.iconSize16,
                                ),
                                onPressed: () => setState(() {
                                  _count++;
                                }),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: ((context, index) {
            return SizedBox(
              height: Dimensions.height10,
            );
          }),
          itemCount: 5),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(width: Dimensions.width10 / 10))),
        height: Dimensions.height20 * 4,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width10, vertical: Dimensions.height10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Total Cost',
                    style: TextStyle(fontSize: Dimensions.font16),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Text(
                    'GHC 13.50',
                    style: TextStyle(
                        fontSize: Dimensions.font16,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              Container(
                height: Dimensions.height20 * 2.5,
                width: Dimensions.width20 * 8,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 13, 71, 118),
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius15 - 5)),
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                  child: Text(
                    'CONFIRM SALES',
                    style: TextStyle(
                        fontSize: Dimensions.font16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
