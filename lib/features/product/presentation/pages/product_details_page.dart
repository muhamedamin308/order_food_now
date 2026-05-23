import 'package:flutter/material.dart';
import 'package:order_now/core/constants/app_colors.dart';
import 'package:order_now/features/product/presentation/widgets/spicy_slider.dart';
import 'package:order_now/features/product/presentation/widgets/topping_item.dart';
import 'package:order_now/shared/widgets/custom_button.dart';
import 'package:order_now/shared/widgets/custom_text.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios, color: AppColors.black),
        ),
        title: Text(
          '{Burger Name} Details',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        // ✅ Bug 2 fixed — prevents overflow
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Bug 1 fixed — removed the Row wrapper
              ProductCustomizeHeader(
                productImage: 'assets/images/burger_logo.png',
                onBack: () => Navigator.pop(context),
              ),

              const SizedBox(height: 20),

              Text(
                'Toppings',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                clipBehavior: Clip.none,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(12, (index) {
                    return ToppingCard(
                      imageUrl: 'assets/images/burger_logo.png',
                      title: 'Tomato',
                      color: Colors.white,
                      onAdd: () {},
                    );
                  }),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Sides',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                clipBehavior: Clip.none,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(12, (index) {
                    return ToppingCard(
                      imageUrl: 'assets/images/burger_logo.png',
                      title: 'Fries',
                      color: Colors.white,
                      onAdd: () {},
                    );
                  }),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: 'Total', size: 20),
                      CustomText(text: '\$ 23.4', size: 30),
                    ],
                  ),
                  CustomButton(text: 'Add to card'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
