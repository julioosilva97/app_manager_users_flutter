import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:manager_users/modules/permission/permission_page.dart';
import 'package:manager_users/modules/profile/profile_page.dart';
import 'package:manager_users/modules/user/user_page.dart';

class BottomBarProvider extends ChangeNotifier {
  List<Widget> pageList = [
    UserPage(),
    ProfilePage(),
    PermissionPage(),
  ];

  int selectedIndex = 0;

  String titleAppBar = 'Usuários';

  Map<String, Widget> contentBottomNavigationBar = {
    'Usuários': Icon(
      Icons.person,
    ),
    'Perfis': Icon(
      Icons.assignment,
    ),
    'Permissões': Icon(
      Icons.check,
    ),
  };

  Widget getPage() {
    return pageList[selectedIndex];
  }

  void updateSelectedIndex(int currentIndex) {
    selectedIndex = currentIndex;
    switch (selectedIndex) {
      case 0:
        titleAppBar = 'Usuários';
        break;
      case 1:
        titleAppBar = 'Perfis';
        break;
      case 2:
        titleAppBar = 'Permissões';
        break;
    }
    notifyListeners();
  }
}
