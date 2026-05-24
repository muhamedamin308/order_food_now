// order_history_item_view.dart
import 'package:flutter/material.dart';
import 'package:order_now/core/constants/app_colors.dart';
import 'package:order_now/features/order/domain/model/order_history_item.dart';

class OrderHistoryItemView extends StatelessWidget {
  final OrderHistoryItem item;
  final VoidCallback onReorder;

  const OrderHistoryItemView({
    super.key,
    required this.item,
    required this.onReorder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Top Row: image + details + status ──────────
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    item.image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.fastfood_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      _InfoRow(
                        icon: Icons.shopping_bag_outlined,
                        label: 'Qty: ${item.quantity}',
                      ),
                      const SizedBox(height: 2),
                      _InfoRow(
                        icon: Icons.attach_money_rounded,
                        label: '\$${item.total.toStringAsFixed(2)}',
                        labelStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _InfoRow(
                        icon: Icons.access_time_rounded,
                        label: _formatDate(item.orderedAt),
                        iconColor: Colors.grey,
                        labelStyle: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                // Status badge
                _StatusBadge(status: item.status),
              ],
            ),
          ),

          // ── Divider ────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Divider(height: 1, color: Colors.grey.shade100),
          ),

          // ── Order Again Button ─────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: SizedBox(
              width: double.infinity,
              height: 42,
              child: OutlinedButton.icon(
                onPressed: onReorder,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: BorderSide(color: AppColors.primary, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text(
                  'Order Again',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}

// ── Helpers ────────────────────────────────────────────

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? iconColor;
  final TextStyle? labelStyle;

  const _InfoRow({
    required this.icon,
    required this.label,
    this.iconColor,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 13, color: iconColor ?? Colors.grey.shade600),
        const SizedBox(width: 4),
        Text(
          label,
          style:
              labelStyle ??
              TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final OrderStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      OrderStatus.delivered => ('Delivered', const Color(0xFF2E7D32)),
      OrderStatus.cancelled => ('Cancelled', const Color(0xFFC62828)),
      OrderStatus.processing => ('Processing', const Color(0xFFE65100)),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
