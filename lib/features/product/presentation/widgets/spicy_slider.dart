import 'package:flutter/material.dart';
import 'package:order_now/core/constants/app_colors.dart';

class ProductCustomizeHeader extends StatefulWidget {
  const ProductCustomizeHeader({
    super.key,
    required this.productImage,
    required this.onBack,
  });

  final String productImage;
  final VoidCallback onBack;

  @override
  State<ProductCustomizeHeader> createState() => _ProductCustomizeHeaderState();
}

class _ProductCustomizeHeaderState extends State<ProductCustomizeHeader> {
  double _spicyLevel = 0.72;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Main Card ────────────────────────────────────
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ── Product Image ───────────────────────────
              ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(24),
                ),
                child: Image.asset(
                  widget.productImage,
                  width: 155,
                  height: 210,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Container(
                    width: 155,
                    height: 210,
                    color: Colors.grey.shade100,
                    child: const Icon(
                      Icons.fastfood_outlined,
                      size: 60,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),

              // ── Right Section ───────────────────────────
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 20, 14, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Customize text
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                            height: 1.45,
                          ),
                          children: [
                            TextSpan(
                              text: 'Customize ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text:
                                  'Your Burger to Your Tastes. Ultimate Experience',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Spicy label
                      const Text(
                        'Spicy',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 4),

                      // Slider
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 9,
                          ),
                          overlayShape: const RoundSliderOverlayShape(
                            overlayRadius: 16,
                          ),
                          trackHeight: 4,
                          thumbColor: AppColors.primary,
                          activeTrackColor: AppColors.primary,
                          inactiveTrackColor: Colors.grey.shade200,
                        ),
                        child: Slider(
                          min: 0,
                          max: 1,
                          value: _spicyLevel,
                          onChanged: (v) => setState(() => _spicyLevel = v),
                        ),
                      ),

                      // Cold / Hot labels
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('🥶', style: TextStyle(fontSize: 14)),
                            Text('🌶️', style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
