import 'package:flutter/material.dart';
import 'package:manager_users/modules/home/home_page.dart';
import 'package:manager_users/shared/provider/bottom_bar_provider.dart';
import 'package:manager_users/shared/provider/permission_provider.dart';
import 'package:manager_users/shared/provider/profile_provider.dart';
import 'package:manager_users/shared/provider/user_provider.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomBarProvider>(
          create: (context) => BottomBarProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<ProfileProvider>(
          create: (context) => ProfileProvider(),
        ),
        ChangeNotifierProvider<PermissionProvider>(
          create: (context) => PermissionProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Gerenciar usuários',
        theme: ThemeData(),
        home: HomePage(),
      ),
    );
  }
}
