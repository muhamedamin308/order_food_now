import 'package:flutter/material.dart';
import 'package:order_now/core/constants/app_colors.dart';
import 'package:order_now/features/payment/presentation/widgets/checkout_card.dart';

class PaymentSelector extends StatelessWidget {
  final List<Map<String, dynamic>> methods;
  final int selected;
  final void Function(int) onSelect;

  const PaymentSelector({
    required this.methods,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return CheckoutCard(
      child: Column(
        children: methods.asMap().entries.map((e) {
          final index = e.key;
          final method = e.value;
          final isSelected = selected == index;
          final isLast = index == methods.length - 1;

          return Column(
            children: [
              GestureDetector(
                onTap: () => onSelect(index),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary.withOpacity(0.1)
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          method['icon'] as IconData,
                          size: 18,
                          color: isSelected ? AppColors.primary : Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              method['label'] as String,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? Colors.black87
                                    : Colors.black54,
                              ),
                            ),
                            if ((method['detail'] as String).isNotEmpty)
                              Text(
                                method['detail'] as String,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),
                          ],
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? Center(
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primary,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
              if (!isLast) Divider(height: 1, color: Colors.grey.shade100),
            ],
          );
        }).toList(),
      ),
    );
  }
}
