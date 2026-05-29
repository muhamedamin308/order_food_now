// checkout_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_now/core/constants/app_colors.dart';
import 'package:order_now/features/home/presentation/pages/home_page.dart';
import 'package:order_now/features/payment/presentation/widgets/address_cart.dart';
import 'package:order_now/features/payment/presentation/widgets/delivery_selector.dart';
import 'package:order_now/features/payment/presentation/widgets/order_item_card.dart';
import 'package:order_now/features/payment/presentation/widgets/order_success_sheet.dart';
import 'package:order_now/features/payment/presentation/widgets/payment_selector.dart';
import 'package:order_now/features/payment/presentation/widgets/place_order_bar.dart';
import 'package:order_now/features/payment/presentation/widgets/price_breakdown.dart';
import 'package:order_now/features/payment/presentation/widgets/promo_field.dart';
import 'package:order_now/features/payment/presentation/widgets/section_sliver.dart';
import 'package:order_now/features/payment/presentation/widgets/text_action.dart';
import 'package:order_now/shared/widgets/custom_app_bar.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int _selectedPayment = 0;
  int _selectedDelivery = 0;
  final _promoController = TextEditingController();
  bool _promoApplied = false;

  static const _paymentMethods = [
    {
      'icon': CupertinoIcons.creditcard,
      'label': 'Credit Card',
      'detail': '**** 4242',
    },
    {
      'icon': CupertinoIcons.money_dollar_circle,
      'label': 'Cash on Delivery',
      'detail': '',
    },
    {
      'icon': CupertinoIcons.device_phone_portrait,
      'label': 'Apple Pay',
      'detail': '',
    },
  ];

  static const _deliveryOptions = [
    {'label': 'Standard', 'time': '30–45 min', 'price': 2.99},
    {'label': 'Express', 'time': '15–20 min', 'price': 5.99},
  ];

  double get _subtotal => 8.99;
  double get _deliveryFee =>
      (_deliveryOptions[_selectedDelivery]['price'] as num).toDouble();
  double get _discount => _promoApplied ? 1.80 : 0.0;
  double get _total => _subtotal + _deliveryFee - _discount;

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // ── App Bar ─────────────────────────────
                CustomAppBar(title: 'Checkout', pageContext: context),

                // ── Delivery Address ────────────────────
                SectionSliver(
                  title: 'Delivery Address',
                  trailing: TextAction(label: 'Change', onTap: () {}),
                  child: AddressCard(),
                ),

                // ── Delivery Type ───────────────────────
                SectionSliver(
                  title: 'Delivery Type',
                  child: DeliverySelector(
                    options: _deliveryOptions,
                    selected: _selectedDelivery,
                    onSelect: (i) => setState(() => _selectedDelivery = i),
                  ),
                ),

                // ── Order Item ──────────────────────────
                SectionSliver(
                  title: 'Your Order',
                  trailing: TextAction(label: 'Edit', onTap: () {}),
                  child: OrderItemCard(),
                ),

                // ── Payment Method ──────────────────────
                SectionSliver(
                  title: 'Payment Method',
                  child: PaymentSelector(
                    methods: _paymentMethods,
                    selected: _selectedPayment,
                    onSelect: (i) => setState(() => _selectedPayment = i),
                  ),
                ),

                // ── Promo Code ──────────────────────────
                SectionSliver(
                  title: 'Promo Code',
                  child: PromoField(
                    controller: _promoController,
                    applied: _promoApplied,
                    onApply: () {
                      if (_promoController.text.trim().isNotEmpty) {
                        setState(() => _promoApplied = true);
                        FocusScope.of(context).unfocus();
                      }
                    },
                    onRemove: () => setState(() {
                      _promoApplied = false;
                      _promoController.clear();
                    }),
                  ),
                ),

                // ── Price Breakdown ─────────────────────
                SectionSliver(
                  title: 'Price Details',
                  child: PriceBreakdown(
                    subtotal: _subtotal,
                    deliveryFee: _deliveryFee,
                    discount: _discount,
                    total: _total,
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 120)),
              ],
            ),
          ),
        ],
      ),

      // ── Bottom Place Order Bar ───────────────────────
      bottomNavigationBar: PlaceOrderBar(
        total: _total,
        onTap: () => _showOrderSuccess(context),
      ),
    );
  }

  void _showOrderSuccess(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => OrderSuccessSheet(
        onDone: () {
          Navigator.pop(context); // close sheet
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
          );
        },
      ),
    );
  }
}
