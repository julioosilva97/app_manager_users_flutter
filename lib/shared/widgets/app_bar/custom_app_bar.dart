import 'package:flutter/material.dart';
import 'package:manager_users/shared/provider/bottom_bar_provider.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(Provider.of<BottomBarProvider>(context).titleAppBar),
    );
  }
}
