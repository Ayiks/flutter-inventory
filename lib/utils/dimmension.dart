import 'package:get/get.dart';

class Dimensions {
  //this get the device's size aoutomatically
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  /*the size of the screen divided by the
  hieght/width/size of the widget to get the dividing factor*/

  //dynamic sizedbox heights padding and margin
  static double height10 = screenHeight / 84.4;
  static double height15 = screenHeight / 56.27;
  static double height20 = screenHeight / 42.2;
  static double height30 = screenHeight / 28.13;
  static double height45 = screenHeight / 18.76;
  //static double height150 = screenHeight / 5.626;

  //dynamic sizedbox width padding and margin
  static double width10 = screenHeight / 84.4;
  static double width15 = screenHeight / 56.27;
  static double width20 = screenHeight / 42.2;
  static double width30 = screenHeight / 28.13;
  //static double width90 = screenHeight / 9.37;

  //dynamic font size
  static double font16 = screenHeight / 52.75;
  static double font20 = screenHeight / 42.2;
  static double font26 = screenHeight / 32.46;

  static double radius15 = screenHeight / 56.27;
  static double radius20 = screenHeight / 42.2;
  static double radius30 = screenHeight / 28.13;

  //icon size
  static double iconSize24 = screenHeight / 35.17;
  static double iconSize16 = screenHeight / 52.75;

  //listview size
  static double listViewImgSize = screenWidth / 3.25;
  static double listViewTextContSize = screenWidth / 3.9;

  

  //bottom height
  static double bottomHeightBar = screenHeight / 7.03;
}
