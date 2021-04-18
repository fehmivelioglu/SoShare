import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'category_screen.dart';
import 'new_screen.dart';
import 'petitions_screen.dart';
import 'profile_screen.dart';

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
    _tabController = TabController(length: 5, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SoShare'),),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            PetitionsScreen(type: 'bagis'),
            PetitionsScreen(type: 'imza'),
            NewScreen(),
            Kategoriler(),
            Profile()
          ],
        ),
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Colors.indigo[500],
          items: [
            TabItem(icon: Icons.attach_money, title: 'Bağışlar'),
            TabItem(icon: Icons.edit, title: 'İmzalar'),
            TabItem(icon: Icons.add, title: 'Yeni'),
            TabItem(icon: Icons.list, title: 'Kategoriler'),
            TabItem(icon: Icons.person, title: 'Profil'),
          ],
          controller: _tabController,
        ));
  }
}
