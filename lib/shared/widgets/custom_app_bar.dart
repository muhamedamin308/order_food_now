import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required this.pageContext,
  });
  final String title;
  final BuildContext pageContext;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 8,
          bottom: 16,
          left: 8,
          right: 16,
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(pageContext),
              icon: Icon(CupertinoIcons.arrow_left, size: 20),
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 44),
          ],
        ),
      ),
    );
  }
}
