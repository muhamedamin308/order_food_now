import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

Widget buildHeader(BuildContext context) {
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
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: AppColors.hintText),
                ),
                Text(
                  'Muhammed Amin',
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
        CircleAvatar(radius: 25, backgroundColor: AppColors.primary, child: Icon(CupertinoIcons.person, color: AppColors.white
          ,),),
      ],
    ),
  );
}
