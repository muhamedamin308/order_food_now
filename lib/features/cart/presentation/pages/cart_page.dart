// cart_page.dart
import 'package:flutter/material.dart';
import 'package:order_now/core/constants/app_colors.dart';
import 'package:order_now/features/cart/domain/model/cart_item_model.dart';
import 'package:order_now/features/cart/presentation/widgets/cart_item_view.dart';
import 'package:order_now/shared/widgets/custom_button.dart';
import 'package:order_now/shared/widgets/custom_text.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // ✅ Each item has its own state
  final List<CartItemModel> _items = List.generate(
    6,
    (i) => CartItemModel(
      id: 'item_$i',
      image: 'assets/images/burger_logo.png',
      title: 'Hamburger',
      description: 'Veggie Burger',
      price: 8.99,
      quantity: 2,
    ),
  );

  double get _total =>
      _items.fold(0, (sum, item) => sum + item.price * item.quantity);

  void _increment(int index) {
    setState(() => _items[index].quantity++);
  }

  void _decrement(int index) {
    setState(() {
      if (_items[index].quantity > 1) _items[index].quantity--;
    });
  }

  void _remove(int index) {
    setState(() => _items.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: CustomText(
                text: 'My Cart',
                size: 24,
                weight: FontWeight.bold,
              ),
            ),

            Expanded(
              child: _items.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: CartItemView(
                            id: item.id,
                            image: item.image,
                            title: item.title,
                            description: item.description,
                            quantity: item.quantity,
                            price: item.price,
                            onIncrement: () => _increment(index),
                            onDecrement: () => _decrement(index),
                            onRemove: () => _remove(index),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      // ✅ bottomNavigationBar — stable, no flicker, auto-adjusts for keyboard
      bottomNavigationBar: _items.isEmpty
          ? null
          : _BottomCheckoutBar(total: _total),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 72,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          CustomText(text: 'Your cart is empty', size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}

// ✅ Extracted to avoid rebuilding on every setState
class _BottomCheckoutBar extends StatelessWidget {
  final double total;

  const _BottomCheckoutBar({required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(text: 'Total', size: 13, color: Colors.grey),
              CustomText(
                text: '\$${total.toStringAsFixed(2)}',
                size: 22,
                weight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(width: 160, child: CustomButton(text: 'Checkout')),
        ],
      ),
    );
  }
}
