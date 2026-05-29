import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_now/features/auth/presentation/pages/edit_profile_page.dart';

import '../../../../core/constants/app_colors.dart';

class HomeHeaderView extends StatelessWidget {
  const HomeHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Order Now',
                textScaler: TextScaler.linear(1.0),
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  fontFamily: 'Chewy',
                ),
              ),
              Row(
                children: [
                  Text(
                    'Hello, ',
                    textScaler: TextScaler.linear(1.0),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.hintText,
                    ),
                  ),
                  Text(
                    'Muhammed Amin',
                    textScaler: TextScaler.linear(1.0),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.mainText,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfilePage(),
                ),
              );
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: AppColors.primary,
              child: Icon(CupertinoIcons.person, color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
