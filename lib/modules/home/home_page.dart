import 'package:flutter/material.dart';
import 'package:manager_users/shared/provider/bottom_bar_provider.dart';
import 'package:manager_users/shared/widgets/app_bar/custom_app_bar.dart';
import 'package:manager_users/shared/widgets/bottom_navigation/custom_bottom_navigation.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigation(),
      body: Provider.of<BottomBarProvider>(context).getPage(),
    );
  }
}
