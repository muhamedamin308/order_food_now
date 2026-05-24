// sliver_grid_item_view.dart — updated signature
import 'package:flutter/material.dart';
import 'package:order_now/features/home/presentation/widgets/product_item.dart';
import 'package:order_now/features/product/presentation/pages/product_details_page.dart';

Widget buildSliverProducts({
  required List<Map<String, dynamic>> products,
  required Set<int> favorites,
  required void Function(int index) onFavoriteTap,
}) {
  return SliverPadding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    sliver: SliverGrid(
      delegate: SliverChildBuilderDelegate(childCount: products.length, (
        context,
        index,
      ) {
        final p = products[index];
        return ProductItem(
          imageUrl: 'assets/images/burger_logo.png',
          name: p['name'] as String,
          subtitle: p['subtitle'] as String,
          rating: (p['rating'] as num).toDouble(),
          price: (p['price'] as num).toDouble(),
          isFavorite: favorites.contains(index),
          onFavoriteTap: () => onFavoriteTap(index),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProductDetailsPage()),
          ),
        );
      }),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
    ),
  );
}
