import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_now/core/constants/app_colors.dart';

enum SnackBarType { success, error }

class CustomSnackBar {
  CustomSnackBar._();

  static void _show(
    BuildContext context, {
    required String message,
    required SnackBarType type,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          duration: duration,
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          padding: EdgeInsets.zero,
          content: _SnackBarContent(message: message, type: type),
        ),
      );
  }

  /// Shortcut for success messages.
  static void showSuccess(BuildContext context, String message) =>
      _show(context, message: message, type: SnackBarType.success);

  /// Shortcut for error messages.
  static void showError(BuildContext context, String message) =>
      _show(context, message: message, type: SnackBarType.error);
}

class _SnackBarContent extends StatelessWidget {
  final String message;
  final SnackBarType type;

  const _SnackBarContent({required this.message, required this.type});

  @override
  Widget build(BuildContext context) {
    final isSuccess = type == SnackBarType.success;
    final bgColor = isSuccess ? AppColors.success : AppColors.error;
    final icon = isSuccess
        ? CupertinoIcons.checkmark_circle_fill
        : CupertinoIcons.exclamationmark_circle_fill;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: bgColor.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textScaler: TextScaler.linear(1.0),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
