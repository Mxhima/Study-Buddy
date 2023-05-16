import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final List<CustomNavItem> items;

  CustomBottomNavigationBar({required this.items});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: items.map((item) {
        return BottomNavigationBarItem(
          icon: Icon(item.icon),
          label: item.title,
        );
      }).toList(),
      onTap: (index) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => items[index].screen),
        );
      },
    );
  }
}

class CustomNavItem {
  final String title;
  final IconData icon;
  final Widget screen;

  CustomNavItem(
      {required this.title, required this.icon, required this.screen});
}
