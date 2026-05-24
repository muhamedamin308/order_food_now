import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_now/features/auth/presentation/pages/profile_page.dart';
import 'package:order_now/features/cart/presentation/pages/cart_page.dart';
import 'package:order_now/features/home/presentation/pages/home_page.dart';
import 'package:order_now/features/order/presentation/pages/order_history_page.dart';

import 'core/constants/app_colors.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late PageController _pageController;
  late List<Widget> _pages;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      HomePage(),
      CartPage(),
      OrderHistoryPage(),
      ProfilePage(),
    ];
    _pageController = PageController(initialPage: currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: currentPage,
          onTap: (index) {
            setState(() {
              currentPage = index;
            });
            _pageController.jumpToPage(currentPage);
          },
          elevation: 0,
          backgroundColor: AppColors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.hintText,

          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_restaurant_outlined),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
