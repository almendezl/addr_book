import 'package:addr_book/core/ui/atoms/custom_icon_button.dart';
import 'package:addr_book/core/ui/molecules/appbar_title.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBack;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurpleAccent,
      elevation: 4,
      centerTitle: true,
      leading: showBack
          ? CustomIconButton(
              icon: Icons.arrow_back,
              onPressed: () => Navigator.of(context).pop(),
              color: Colors.white,
            )
          : null,
      title: AppBarTitle(text: title),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
