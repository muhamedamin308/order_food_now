import 'package:flutter/cupertino.dart';
import 'package:order_now/features/home/presentation/widgets/product_item.dart';

Widget buildSliverProducts(List<String> products) {
  return SliverPadding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    sliver: SliverGrid(
      delegate: SliverChildBuilderDelegate(
        childCount: products.length,
            (context, index) => ProductItem(
          imageUrl: 'assets/images/burger_logo.png',
          name: products[index],
          subtitle: '${products[index]} description',
          rating: (index + 1).toDouble(),
          onTap: () {},
        ),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
    ),
  );
}