// cart_item_model.dart
class CartItemModel {
  final String image;
  final String title;
  final String description;
  final double price;
  int quantity;

  CartItemModel({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    this.quantity = 1,
  });
}