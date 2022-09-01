import 'package:flutter/material.dart';
import 'package:userapp/screens/account.dart';
import 'package:userapp/screens/cart.dart';
import 'package:userapp/screens/home.dart';
import 'package:userapp/screens/searchbar.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _currentIndex = 0;
  List _pages = [
    HomeScreen(),
    CartScreen(),
    AccountScreen(),
  ];

  changeIndex(selectedIndex) {
    setState(() {
      _currentIndex = selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: changeIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined), label: "Cart"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box_outlined), label: "Account"),
          ],
        ));
  }
}
