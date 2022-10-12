import 'package:flutter/material.dart';
import 'package:inventory_1/utils/dimmension.dart';

class ContainAcc extends StatelessWidget {
  String text1;
  String text2;
  IconData icon4;
  ContainAcc(
      {Key? key, required this.text1, required this.text2, required this.icon4})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width10),
      height: Dimensions.height20 * 4,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: Dimensions.width10 / 10))),
      child: Row(
        children: [
          Icon(
            icon4,
            color: Color.fromARGB(255, 7, 85, 148),
          ),
          SizedBox(
            width: Dimensions.width10,
          ),
          Text(
            text1,
            style: TextStyle(
                fontSize: Dimensions.font16, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: Dimensions.width20,
          ),
          Text(
            text2,
            style: TextStyle(
                fontSize: Dimensions.font16, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
