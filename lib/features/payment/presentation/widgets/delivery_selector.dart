// ── Delivery Selector ──────────────────────────────────

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_now/core/constants/app_colors.dart';

class DeliverySelector extends StatelessWidget {
  final List<Map<String, dynamic>> options;
  final int selected;
  final void Function(int) onSelect;

  const DeliverySelector({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: options.asMap().entries.map((e) {
        final index = e.key;
        final option = e.value;
        final isSelected = selected == index;
        return Expanded(
          child: GestureDetector(
            onTap: () => onSelect(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.only(right: index == 0 ? 10 : 0),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.grey.shade200,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option['label'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    option['time'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      color: isSelected
                          ? Colors.white.withOpacity(0.75)
                          : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$${(option['price'] as num).toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: isSelected ? Colors.white : AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
