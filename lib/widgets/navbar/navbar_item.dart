import 'package:ecommerce_admin_tut/services/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class NavBarItem extends StatelessWidget {
  final String title;
  final String navigationPath;
  const NavBarItem({this.title, this.navigationPath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: Text(
        title,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}