// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:inventory_1/models/product.dart';

// class CartModel {
//   CartModel(
//       {this.id,
//       this.name,
//       this.type,
//       this.price,
//       this.quantity,
//       this.isExit,
//       this.time,
//       this.product});

//   int? id;
//   String? name;
//   String? type;
//   int? quantity;
//   double? price;
//   bool? isExit;
//   String? time;
//   Product? product;

//   factory CartModel.fromDocumentSnapshot(
//           DocumentSnapshot<Map<String, dynamic>> doc) =>
//       CartModel(
//           id: doc.data()!['id'],
//           name: doc.data()!['name'],
//           type: doc.data()!['type'],
//           price: doc.data()!['costPrice'],
//           quantity: doc.data()!['quantity'],
//           isExit: doc.data()!['isExit'],
//           time: doc.data()!['time'],
//           product: Product.fromDocumentSnapshot(doc.data()!['product']));

//   Map<String, dynamic> toJson() => {
//         'id':id,
//         'name': name,
//         'type': type,
//         'price': price,
//         'quantity': quantity,
//         'isExit': isExit,
//         'time': time,
//         'product':product!.toJson()
//       };
// }

import 'package:inventory_1/models/product.dart';

class CartModel {
  int? id;
  String? name;
  String? type;
  double? price;
  int? quantity;
  bool? isExit;
  String? time;
  Product? product;

  CartModel(
      {this.id,
      this.name,
      this.type,
      this.price,
      this.quantity,
      this.isExit,
      this.time,
      this.product});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    price = json['price'];
    quantity = json['quantity'];
    isExit = json['isExit'];
    time = json['time'];
    product = Product.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "type" : this.type,
      "price": this.price,
      "quantity": this.quantity,
      "isExist": this.isExit,
      "time": this.time,
      "product": this.product!.toJson()
    };
  }
}
