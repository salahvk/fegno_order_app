class CartItem {
  final String itemName;
  final double price;
  final int quantity;
  final String quantityUnit;
  final String imageUrl;

  CartItem({
    required this.itemName,
    required this.price,
    required this.quantity,
    required this.quantityUnit,
    required this.imageUrl,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      itemName: json['itemName'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      quantityUnit: json['quantityUnit'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'price': price,
      'quantity': quantity,
      'quantityUnit': quantityUnit,
      'imageUrl': imageUrl,
    };
  }
}
