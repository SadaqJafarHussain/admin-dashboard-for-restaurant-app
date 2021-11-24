import 'package:ecommerce_admin_tut/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'card_item.dart';

class CardsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Container(
      height: 80,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: CardItem(
                icon: Icons.monetization_on_outlined,
                title: "الارباح",
                subtitle: "ارباح هذا الشهر",
                value: " ${appProvider.revenue} IQD",
                color1: Colors.green.shade700,
                color2: Colors.green,
              ),
            ),
            CardItem(
              icon: Icons.shopping_basket_outlined,
              title: "المنتجات",
              subtitle: "عدد المنتجات في المخزن",
              value: "${90}",
              color1: Colors.lightBlueAccent,
              color2: Colors.blue,
            ),
            CardItem(
              icon: Icons.delivery_dining,
              title: "الطلبات",
              subtitle: "جميع الطلبات خلال هذا الشهر",
              value: "${0}",
              color1: Colors.redAccent,
              color2: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
