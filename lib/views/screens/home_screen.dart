import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:soshare/views/screens/category_screen.dart';
import 'package:soshare/views/screens/first_screen.dart';
import 'package:soshare/views/screens/new_screen.dart';
import 'package:soshare/views/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            Bagislar(),
            Imzalar(),
            NewScreen(),
            Kategoriler(),
            Profile()
          ],
        ),
        bottomNavigationBar: ConvexAppBar(
          items: [
            TabItem(icon: Icons.attach_money, title: 'Bağışlar'),
            TabItem(icon: Icons.edit, title: 'İmzalar'),
            TabItem(icon: Icons.add, title: 'Yeni'),
            TabItem(icon: Icons.list, title: 'Kategoriler'),
            TabItem(icon: Icons.person, title: 'Profil'),
          ],
          controller: _tabController,
          onTap: (int i) => print('click index=$i'),
        ));
  }
}
