// order_page.dart
import 'package:flutter/material.dart';
import 'package:order_now/features/order/domain/model/order_history_item.dart';
import 'package:order_now/shared/widgets/custom_text.dart';
import '../widgets/order_history_item_view.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  // In real app this comes from BLoC/ViewModel
  static final List<OrderHistoryItem> _mockOrders = [
    OrderHistoryItem(
      image: 'assets/images/burger_logo.png',
      name: 'Hamburger Deluxe',
      quantity: 3,
      price: 8.99,
      orderedAt: DateTime(2025, 5, 18),
      status: OrderStatus.delivered,
    ),
    OrderHistoryItem(
      image: 'assets/images/burger_logo.png',
      name: 'Veggie Burger',
      quantity: 2,
      price: 7.49,
      orderedAt: DateTime(2025, 5, 10),
      status: OrderStatus.delivered,
    ),
    OrderHistoryItem(
      image: 'assets/images/burger_logo.png',
      name: 'Cheeseburger',
      quantity: 1,
      price: 9.99,
      orderedAt: DateTime(2025, 4, 28),
      status: OrderStatus.cancelled,
    ),
    OrderHistoryItem(
      image: 'assets/images/burger_logo.png',
      name: 'Chicken Burger',
      quantity: 2,
      price: 8.49,
      orderedAt: DateTime(2025, 4, 15),
      status: OrderStatus.processing,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
              child: CustomText(
                text: 'Order History',
                size: 24,
                weight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: CustomText(
                text: '${_mockOrders.length} orders placed',
                size: 13,
                color: Colors.grey,
              ),
            ),

            // List
            Expanded(
              child: _mockOrders.isEmpty
                  ? _EmptyOrderState()
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                      itemCount: _mockOrders.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return OrderHistoryItemView(
                          item: _mockOrders[index],
                          onReorder: () {
                            // TODO: add to cart
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyOrderState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'No orders yet',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Your order history will appear here',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }
}
