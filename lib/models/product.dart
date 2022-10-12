// import 'package:cloud_firestore/cloud_firestore.dart';

// class ProductModel {
//   late List<Product> _products;
//   List<Product> get products => _products;

//   ProductModel({required products}) {
//     this._products = products;
//   }

// //  factory ProductModel.fromDocumentSanpshot(
// //    DocumentSnapshot<Map<String, dynamic>> doc) =>
// //       ProductModel(products: _products.add(value)

// //        );

// }

// class Product {
//   Product({
//     required this.name,
//     required this.type,
//     required this.price,
//     required this.quantity,
//     required this.lowOnStock,
//     this.productId,
//     this.createdAt,
//   });

//   String name;
//   String type;
//   double price;
//   int quantity;
//   int lowOnStock;
//   int? productId;
//   String? createdAt;

//   factory Product.fromDocumentSnapshot(
//           DocumentSnapshot<Map<String, dynamic>> doc) =>
//       Product(
//           name: doc.data()!['name'],
//           type: doc.data()!['type'],
//           price: doc.data()!['costPrice'],
//           quantity: doc.data()!['quantity'],
//           lowOnStock: doc.data()!['lowOnStock'],
//           productId: doc.data()!['productId'],
//           createdAt: doc.data()!['createdAt']);

//   Map<String, dynamic> toJson() => {
//         'name': name,
//         'type': type,
//         'costPrice': price,
//         'quantity': quantity,
//         'lowOnStock': lowOnStock,
//         'productId': productId,
//         'createdAt': createdAt
//       };
// }

class ProductModel {
  late List<ProductModel> _products;
  List<ProductModel> get products => _products;

  Product({required products}) {
    this._products = products;
  }

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      _products = <ProductModel>[];
      json['products'].forEach((v) {
        products.add(ProductModel.fromJson(v));
      });
    }
  }
}

class Product {
  String? id;
  String? name;
  String? type;
  double? price;
  int? quantity;
  String? createdAt;
  int? productId;
  int? lowOnStock;

  Product(
      {this.id,
      this.name,
      this.type,
      this.price,
      this.quantity,
      this.createdAt,
      this.productId,
      this.lowOnStock});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    type = json['type'];
    price = double.parse("${json['costPrice']}");
    quantity = json['quantity'];
    createdAt = json['created_at'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "type": this.type,
      "price": this.price,
      "quantity": this.quantity,
      "createdAt": this.createdAt,
      "productId": this.productId
    };
  }
}
