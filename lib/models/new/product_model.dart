class ProductModel {
  static const ID = "id";
  static const NAME = "name";
  static const TYPE = "type";
  static const QUANTITY = "quantity";
  static const PRICE = "price";

  String? id;
  String? name;
  String? type;
  int? quantity;
  double? price;

  ProductModel({this.id, this.name, this.type, this.quantity, this.price});

  ProductModel.fromMap(Map<String, dynamic> data) {
    id = data[ID];
    name = data[NAME];
    type = data[TYPE];
    quantity = data[QUANTITY].toInt();
    price = data[PRICE].toDouble();
  }
}
