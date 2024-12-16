import 'package:todo_app/shared/palette.dart';
import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;

  const AppBarComponent({
    super.key,
    required this.title,
    this.actions,
    this.leading,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      elevation: 4,
      shadowColor: Palette.grey400,
      backgroundColor: Palette.primary,
      surfaceTintColor: Palette.primary,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Palette.white,
        ),
      ),
      leading: leading,
      actions: actions,
    );
  }
}
