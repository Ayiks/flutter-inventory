import 'package:flutter/material.dart';
import 'package:inventory_1/utils/dimmension.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class addmore extends StatefulWidget {
  const addmore({
    Key? key,
  }) : super(key: key);

  @override
  State<addmore> createState() => _addmoreState();
}

class _addmoreState extends State<addmore> {
  TextEditingController _quantitysaleContrller = TextEditingController();
  int _count = 0;
  int count = 0;

  void _incrementCount() {
    setState(() {
      count = _count++;
    });
  }

  void _decrementCount() {
    setState(() {
      count = _count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => showMaterialModalBottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(Dimensions.radius20))),
          context: context,
          builder: (context) {
            return ListView(
              padding: EdgeInsets.only(top: 10),
              children: [
                Center(
                  child: Text(
                    'Item List',
                    style: TextStyle(fontSize: Dimensions.font20),
                  ),
                ),
                ListView.separated(
                    physics:
                        ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    shrinkWrap: true,
                    itemBuilder: (Context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Colors.black))),
                          child: Row(
                            children: [
                              Text(
                                'Fish Kpanla',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text('Quantity', style: TextStyle(fontSize: 16)),
                              Text('$count', style: TextStyle(fontSize: 16)),
                              Container(
                                  color: Colors.black12,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: _decrementCount,
                                          icon: Icon(Icons.chevron_left)),
                                      IconButton(
                                          onPressed: _incrementCount,
                                          icon: Icon(
                                            Icons.chevron_right,
                                          )),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (Context, index) {
                      return SizedBox(
                        height: 1,
                      );
                    },
                    itemCount: 2),
              ],
            );
          })),
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: Text(
          'Add Item',
          style: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
