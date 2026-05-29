import 'package:flutter/cupertino.dart';

import '../../../../shared/widgets/custom_text_field.dart';

class SearchBarView extends StatelessWidget {
  const SearchBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomTextField(
        hint: 'Search for food',
        prefixIcon: CupertinoIcons.search,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        borderRadius: 12,
      ),
    );
  }
}
