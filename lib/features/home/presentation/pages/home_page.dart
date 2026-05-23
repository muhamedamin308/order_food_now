import 'package:flutter/material.dart';
import 'package:order_now/core/constants/app_colors.dart';

import '../widgets/home_header_view.dart';
import '../widgets/search_bar_view.dart';
import '../widgets/sliver_grid_item_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const List<String> categories = [
    'Pizza',
    'Burgers',
    'Sushi',
    'Desserts',
    'Drinks',
  ];

  static const List<String> products = [
    'Margherita Pizza',
    'Cheeseburger',
    'California Roll',
    'Chocolate Cake',
    'Lemonade',
  ];

  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              pinned: true,
              scrolledUnderElevation: 0,
              automaticallyImplyLeading: false,
              toolbarHeight: 148,
              flexibleSpace: SafeArea(
                child: Column(
                  children: [
                    buildHeader(context),
                    buildSearchBar(),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _buildCategories(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            buildSliverProducts(products),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 50, // ✅ Bug 1 fixed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = selectedCategoryIndex == index;
          return GestureDetector(
            onTap: () => setState(() => selectedCategoryIndex = index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: isSelected ? AppColors.white : AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
