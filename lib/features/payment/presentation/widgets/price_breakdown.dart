// ── Price Breakdown ────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:order_now/core/constants/app_colors.dart';
import 'package:order_now/features/payment/presentation/widgets/checkout_card.dart';
import 'package:order_now/features/payment/presentation/widgets/price_row.dart';

class PriceBreakdown extends StatelessWidget {
  final double subtotal;
  final double deliveryFee;
  final double discount;
  final double total;

  const PriceBreakdown({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return CheckoutCard(
      child: Column(
        children: [
          PriceRow(
            label: 'Subtotal',
            value: '\$${subtotal.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 10),
          PriceRow(
            label: 'Delivery Fee',
            value: '\$${deliveryFee.toStringAsFixed(2)}',
          ),
          if (discount > 0) ...[
            const SizedBox(height: 10),
            PriceRow(
              label: 'Promo Discount',
              value: '−\$${discount.toStringAsFixed(2)}',
              valueColor: Colors.green.shade600,
            ),
          ],
          const SizedBox(height: 14),
          Divider(color: Colors.grey.shade100, height: 1),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
