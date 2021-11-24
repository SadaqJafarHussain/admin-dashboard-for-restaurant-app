import 'package:ecommerce_admin_tut/pages/add_category.dart';
import 'package:ecommerce_admin_tut/pages/add_product.dart';
import 'package:ecommerce_admin_tut/pages/categories/categories_page.dart';
import 'package:ecommerce_admin_tut/pages/edit_product.dart';
import 'package:ecommerce_admin_tut/pages/home/desktop.dart';
import 'package:ecommerce_admin_tut/pages/orders/orders_page.dart';
import 'package:ecommerce_admin_tut/pages/products/products_page.dart';
import 'package:ecommerce_admin_tut/pages/users/users_page.dart';
import 'package:ecommerce_admin_tut/providers/app_provider.dart';
import 'package:ecommerce_admin_tut/widgets/navbar/navigation_bar.dart' as nav;
import 'package:ecommerce_admin_tut/widgets/side_menu/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LayoutTemplate extends StatefulWidget {
  @override
  State<LayoutTemplate> createState() => _LayoutTemplateState();
}
class _LayoutTemplateState extends State<LayoutTemplate> {
List<Widget> screens=[
  HomePageDesktop(),
  UsersPage(),
  OrdersPage(),
  CategoriesPage(),
  AddProduct(),
  ProductsPage(),
  AddCategory(),
  EditProduct(),
];

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        textDirection: TextDirection.rtl,
        children: [
          SideMenu(),
          Expanded(
            child: Column(
              children: [
                nav.NavigationBar(),
                Expanded(
                  child: screens[provider.index],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
