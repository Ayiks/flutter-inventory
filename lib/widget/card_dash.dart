import 'package:flutter/material.dart';
import 'package:inventory_1/utils/dimmension.dart';

class CardDash extends StatelessWidget {
  IconData icon;
  String text;
  Color? color;
  String number;

  CardDash(
      {Key? key,
      required this.icon,
      required this.text,
      this.color,
      required this.number})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: Dimensions.height20 * 5,
      width: Dimensions.width20 * 9,
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                size: Dimensions.iconSize24 + 6,
                color: color,
              ),
              Text(
                number,
                style: TextStyle(
                    fontSize: Dimensions.font20 + 5,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: Dimensions.height20,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: Dimensions.font16, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
