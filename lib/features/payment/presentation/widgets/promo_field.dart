// ── Promo Field ────────────────────────────────────────

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_now/core/constants/app_colors.dart';

class PromoField extends StatelessWidget {
  final TextEditingController controller;
  final bool applied;
  final VoidCallback onApply;
  final VoidCallback onRemove;

  const PromoField({
    super.key,
    required this.controller,
    required this.applied,
    required this.onApply,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: applied ? AppColors.primary : Colors.grey.shade200,
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 14),
                Icon(
                  CupertinoIcons.tag,
                  size: 18,
                  color: applied ? AppColors.primary : Colors.grey,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: applied
                      ? Text(
                          controller.text,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        )
                      : TextField(
                          controller: controller,
                          style: const TextStyle(fontSize: 14),
                          decoration: const InputDecoration(
                            hintText: 'Enter promo code',
                            hintStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                ),
                if (applied)
                  GestureDetector(
                    onTap: onRemove,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Icon(
                        CupertinoIcons.xmark_circle_fill,
                        size: 18,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: applied ? onRemove : onApply,
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: Text(
              applied ? 'Remove' : 'Apply',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
