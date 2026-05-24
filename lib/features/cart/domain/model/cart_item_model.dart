class CartItemModel {
  final String id;
  final String image;
  final String title;
  final String description;
  final double price;
  int quantity;

  CartItemModel({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    this.quantity = 1,
  });

  double get total => price * quantity;
}