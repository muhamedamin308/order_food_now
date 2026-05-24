// order_history_item_model.dart
enum OrderStatus { delivered, cancelled, processing }

class OrderHistoryItem {
  final String image;
  final String name;
  final int quantity;
  final double price;
  final DateTime orderedAt;
  final OrderStatus status;

  const OrderHistoryItem({
    required this.image,
    required this.name,
    required this.quantity,
    required this.price,
    required this.orderedAt,
    required this.status,
  });

  double get total => price * quantity;
}