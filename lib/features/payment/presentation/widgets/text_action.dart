import 'package:flutter/cupertino.dart';
import 'package:order_now/core/constants/app_colors.dart';

class TextAction extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const TextAction({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }
}