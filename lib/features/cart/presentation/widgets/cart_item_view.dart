import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:order_now/core/constants/app_colors.dart';
import 'package:order_now/shared/widgets/custom_text.dart';

class CartItemView extends StatelessWidget {
  const CartItemView({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.quantity,
    required this.onRemove,
    required this.onIncrement,
    required this.onDecrement,
  });
  final String image;
  final String title;
  final String description;
  final int quantity;
  final VoidCallback onRemove;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ── Left: image + name + subtitle ─────────────
            Expanded(
              // ✅ Bug 1 fixed — constrain left side
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/burger_logo.png',
                    width: 100,
                    height: 90,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 6),
                  CustomText(text: 'Cheese Burger', weight: FontWeight.bold),
                  CustomText(text: 'Cheese Burger Description'),
                ],
              ),
            ),

            // ── Right: counter + remove ────────────────────
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Counter row
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _CounterButton(
                      // ✅ Bug 2 fixed — minus icon
                      icon: CupertinoIcons.minus,
                      onTap: onDecrement,
                      color: AppColors.error,
                    ),
                    const Gap(14),
                    CustomText(
                      text: '$quantity',
                      size: 20,
                      weight: FontWeight.w800,
                    ),
                    const Gap(14),
                    _CounterButton(
                      icon: CupertinoIcons.plus,
                      onTap: onIncrement,
                      color: AppColors.success,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Remove button
                GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    height: 42,
                    width: 120,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: CustomText(
                      text: 'Remove',
                      color: AppColors.white,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const _CounterButton({
    required this.icon,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: color,
        radius: 18,
        child: Icon(icon, color: AppColors.white, size: 18),
      ),
    );
  }
}
