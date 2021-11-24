import 'package:ecommerce_admin_tut/helpers/enumerators.dart';
import 'package:ecommerce_admin_tut/pages/categories/categories_page.dart';
import 'package:ecommerce_admin_tut/providers/app_provider.dart';
import 'package:ecommerce_admin_tut/rounting/route_names.dart';
import 'package:ecommerce_admin_tut/services/navigation_service.dart';
import 'package:ecommerce_admin_tut/widgets/navbar/navbar_logo.dart';
import 'package:ecommerce_admin_tut/widgets/side_menu/side_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideMenuTabletDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    return Container(
      decoration: BoxDecoration(
          color: Colors.indigo,
          gradient: LinearGradient(
            colors: [Colors.indigo, Colors.indigo.shade600],
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[200], offset: Offset(3, 5), blurRadius: 17)
          ]),
      width: 250,
      child: Container(
        child: Column(
          children: [
            NavBarLogo(),
            Directionality(
              textDirection: TextDirection.rtl,
              child: SideMenuItemDesktop(
                icon: Icons.dashboard,
                text: 'الصفحه الرئيسية',
                active: appProvider.index==0,
                onTap: () {
                  appProvider.changeIndex(0);
                },
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: SideMenuItemDesktop(
                icon: Icons.people,
                text: 'الزبائن',
                active: appProvider.index==1,
                onTap: () {
                  appProvider.changeIndex(1);
                },
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: SideMenuItemDesktop(
                icon: Icons.shopping_cart,
                text: 'الطلبات',
                active: appProvider.index==2,
                onTap: () {
                  appProvider.changeIndex(2);
                },
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: SideMenuItemDesktop(
                icon: Icons.shopping_basket_outlined,
                text: 'المنتجات',
                active: appProvider.index==5,
                onTap: () {
                  appProvider.changeIndex(5);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
