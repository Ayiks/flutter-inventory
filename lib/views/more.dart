import 'package:flutter/material.dart';
import 'package:inventory_1/widget/contain_acc.dart';

import '../utils/dimmension.dart';
import 'Colla.dart';

class More extends StatefulWidget {
  const More({Key? key}) : super(key: key);

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Accounts',
          style: TextStyle(fontSize: Dimensions.font20),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Dimensions.height10, horizontal: Dimensions.width10),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: Dimensions.height20 * 10,
              width: double.infinity,
              child: Stack(
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/Profile_avatar.png'),
                      radius: Dimensions.radius20 * 4,
                    ),
                  ),
                  Positioned(
                      bottom: Dimensions.height20,
                      left: Dimensions.width20 * 5,
                      right: Dimensions.width20,
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.photo_camera,
                          size: Dimensions.radius30 + 5,
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: Dimensions.height30,
            ),
            Container(
              child: Column(
                children: [
                  ContainAcc(
                    icon4: Icons.person,
                    text1: 'Name:',
                    text2: 'Nathaniel Asamoah',
                  ),
                  ContainAcc(
                      icon4: Icons.email,
                      text1: 'E-mail:',
                      text2: 'nathanielasamoah@gmail.com'),
                  ContainAcc(
                      icon4: Icons.numbers,
                      text1: 'Number:',
                      text2: '0246089849'),
                  ContainAcc(
                      icon4: Icons.work,
                      text1: 'Company Name:',
                      text2: 'Ghana Company'),
                ],
              ),
            ),
            SizedBox(
              height: Dimensions.height20 * 2,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Colla();
                }));
              },
              child: Container(
                height: Dimensions.height20 * 4,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width10,
                      vertical: Dimensions.height10),
                  child: Row(children: [
                    Icon(
                      Icons.people,
                      size: Dimensions.iconSize24,
                      color: Color.fromARGB(255, 4, 36, 61),
                    ),
                    SizedBox(
                      width: Dimensions.height10,
                    ),
                    Text(
                      'Manage Collabrators',
                      style: TextStyle(
                          fontSize: Dimensions.font16,
                          fontWeight: FontWeight.w400),
                    )
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
