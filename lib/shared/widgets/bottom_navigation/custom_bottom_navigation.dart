import 'package:flutter/material.dart';
import 'package:manager_users/shared/provider/bottom_bar_provider.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.6),
        currentIndex: Provider.of<BottomBarProvider>(context).selectedIndex,
        items: Provider.of<BottomBarProvider>(context)
            .contentBottomNavigationBar
            .map(
              (key, value) => MapEntry(
                key,
                BottomNavigationBarItem(
                  label: key,
                  icon: value,
                ),
              ),
            )
            .values
            .toList(),
        onTap: (int index) {
          Provider.of<BottomBarProvider>(context, listen: false)
              .updateSelectedIndex(index);
        });
  }
}
