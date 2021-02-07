import 'package:flutter/material.dart';
import 'package:newsapp/pages/categoryPage.dart';
import 'package:newsapp/pages/favoritePage.dart';
import 'package:newsapp/pages/readListPage.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PersistentTabController _controller;

  List<Widget> _buildScreens() {
    return [FavoritePage(), CategoryPage(), ListPage()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.favorite),
        title: "Favorite",
        activeColor: Colors.teal,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.menu),
        title: ("Category"),
        activeColor: Colors.teal[200],
        inactiveColor: Colors.grey,
        activeColorAlternate: Colors.white,

      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.book),
        title: ("Read List"),
        activeColor: Colors.teal,
        inactiveColor: Colors.grey,
      ),
    ];
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        decoration: NavBarDecoration(
            colorBehindNavBar: Colors.indigo,
            borderRadius: BorderRadius.circular(20.0)),
        navBarStyle: NavBarStyle.style15,
      ),
    );
  }
}
