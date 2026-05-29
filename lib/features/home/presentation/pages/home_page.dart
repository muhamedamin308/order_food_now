// home_page.dart
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
  static const List<Map<String, String>> categories = [
    {'label': 'Pizza', 'emoji': '🍕'},
    {'label': 'Burgers', 'emoji': '🍔'},
    {'label': 'Sushi', 'emoji': '🍱'},
    {'label': 'Desserts', 'emoji': '🍰'},
    {'label': 'Drinks', 'emoji': '🥤'},
  ];

  static const List<Map<String, dynamic>> products = [
    {
      'name': 'Margherita Pizza',
      'subtitle': "Wendy's Pizza",
      'price': 12.99,
      'rating': 4.9,
    },
    {
      'name': 'Cheeseburger',
      'subtitle': "Burger Palace",
      'price': 8.99,
      'rating': 4.8,
    },
    {
      'name': 'California Roll',
      'subtitle': "Tokyo Bites",
      'price': 14.49,
      'rating': 4.7,
    },
    {
      'name': 'Chocolate Cake',
      'subtitle': "Sweet Treats",
      'price': 6.99,
      'rating': 4.6,
    },
    {'name': 'Lemonade', 'subtitle': "Freshco", 'price': 3.49, 'rating': 4.5},
  ];

  int _selectedCategory = 0;
  final Set<int> _favorites = {};

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F7F7),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // ── Pinned App Bar ─────────────────────────
            SliverAppBar(
              backgroundColor: const Color(0xFFF7F7F7),
              elevation: 0,
              pinned: true,
              scrolledUnderElevation: 0,
              automaticallyImplyLeading: false,
              toolbarHeight: 148,
              flexibleSpace: SafeArea(
                child: Column(children: [HomeHeaderView(), SearchBarView()]),
              ),
            ),

            // ── Promo Banner ───────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: _PromoBanner(),
              ),
            ),

            // ── Categories ─────────────────────────────
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionHeader(title: 'Categories'),
                  SizedBox(
                    height: 52,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final isSelected = _selectedCategory == index;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedCategory = index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: AppColors.primary.withOpacity(
                                          0.3,
                                        ),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Row(
                              children: [
                                Text(
                                  categories[index]['emoji']!,
                                  textScaler: TextScaler.linear(1.0),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  categories[index]['label']!,
                                  textScaler: TextScaler.linear(1.0),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // ── Products section header ─────────────────
            SliverToBoxAdapter(
              child: _SectionHeader(
                title: 'Popular',
                trailing: TextButton(
                  onPressed: () {},
                  child: Text(
                    'See all',
                    textScaler: TextScaler.linear(1.0),
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),

            // ── Products grid ──────────────────────────
            SliverGridItemView(
              products: products,
              favorites: _favorites,
              onFavoriteTap: (index) => setState(
                () => _favorites.contains(index)
                    ? _favorites.remove(index)
                    : _favorites.add(index),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

// ── Reusable section header ────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const _SectionHeader({required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 8, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            textScaler: TextScaler.linear(1.0),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

// ── Promo banner ───────────────────────────────────────

class _PromoBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Limited offer 🔥',
                    textScaler: TextScaler.linear(1.0),
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Get 20% off\nyour first order',
                  textScaler: TextScaler.linear(1.0),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const Text('🍔', style: TextStyle(fontSize: 64)),
        ],
      ),
    );
  }
}
