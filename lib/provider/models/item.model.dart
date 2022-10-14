class Item {
  final String name;
  final int quantity;
  final int price;
  final String image;

  Item(
      {required this.name,
      required this.quantity,
      required this.price,
      required this.image});

  Map toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
      'image': image,
    };
  }
}
