import 'package:flutter/material.dart';
import 'package:inventory_1/utils/dimmension.dart';

class TransHistory extends StatelessWidget {
  const TransHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transaction History',
          style: TextStyle(fontSize: Dimensions.font20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.width10, vertical: Dimensions.height20),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                height: Dimensions.height20 * 9,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius15 - 5)),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        right: Dimensions.width10,
                        left: Dimensions.width20,
                      ),
                      child: Container(
                          height: Dimensions.height20,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: Dimensions.width10 / 10,
                                      color: Colors.grey))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Items',
                                style: TextStyle(
                                    fontSize: Dimensions.font16,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Chicken thigh',
                                style: TextStyle(fontSize: Dimensions.font16),
                              ),
                            ],
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          right: Dimensions.width10,
                          left: Dimensions.width20),
                      child: Container(
                          height: Dimensions.height20,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: Dimensions.width10 / 10,
                                      color: Colors.grey))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Quantity Sold',
                                style: TextStyle(
                                    fontSize: Dimensions.font16,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '15',
                                style: TextStyle(fontSize: Dimensions.font16),
                              ),
                            ],
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          right: Dimensions.width10,
                          left: Dimensions.width20),
                      child: Container(
                          height: Dimensions.height20,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: Dimensions.width10 / 10,
                                      color: Colors.grey))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Amount',
                                style: TextStyle(
                                    fontSize: Dimensions.font16,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'GHC 30.00',
                                style: TextStyle(fontSize: Dimensions.font16),
                              ),
                            ],
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          right: Dimensions.width10,
                          left: Dimensions.width20),
                      child: Container(
                        height: Dimensions.height20,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Date',
                              style: TextStyle(
                                  fontSize: Dimensions.font16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '23 NOV 2022 at 18:30',
                              style: TextStyle(fontSize: Dimensions.font16),
                            ),
                          ],
                        ),
                        // decoration: BoxDecoration(
                        //     border: Border(
                        //         bottom: BorderSide(
                        //             width: Dimensions.width10 / 10,
                        //             color: Colors.grey)))
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: ((context, index) {
              return SizedBox(
                height: Dimensions.height10,
              );
            }),
            itemCount: 5),
      ),
    );
  }
}
