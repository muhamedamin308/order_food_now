// splash_screen.dart

import 'package:flutter/material.dart';
import 'package:order_now/core/constants/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _textFadeIn;
  late Animation<Offset> _burgerSlideUp;
  late Animation<double> _burgerFadeIn;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _textFadeIn = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );

    _burgerSlideUp =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
          ),
        );

    _burgerFadeIn = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.8, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          // "HUNGRY?" text — centered in upper half
          Align(
            alignment: const Alignment(0, -0.25),
            child: FadeTransition(
              opacity: _textFadeIn,
              child: const Text(
                'Order Now',
                style: TextStyle(
                  fontFamily:
                      'Chewy', // swap with your preferred rounded/chunky font
                  fontSize: 52,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 1.5,
                  height: 1,
                ),
              ),
            ),
          ),

          // Burger image — pinned to bottom, slightly overflowing
          Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: _burgerSlideUp,
              child: FadeTransition(
                opacity: _burgerFadeIn,
                child: Image.asset(
                  'assets/images/burger_logo.png', // <-- your asset path
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
