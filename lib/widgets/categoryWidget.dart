import 'package:ecommerce_admin_tut/models/categories.dart';
import 'package:ecommerce_admin_tut/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class  CategoryWidget extends StatelessWidget{
  final CategoriesModel category;
  CategoryWidget({
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<AppProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: 120,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: category.id==provider.showCategoryId?Color(0xffFF334F).withOpacity(0.5):Colors.grey,
              offset: Offset(2,2),
              spreadRadius: 0.0,
              blurRadius: 6,
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            width: 3,
            color:  category.id==provider.showCategoryId?Color(0xffFF334F):Colors.transparent,
          )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(category.category,
            style: TextStyle(
              color: category.id==provider.showCategoryId?Color(0xffFF334F):Colors.grey,
              fontFamily: 'Cairo',
              fontSize: 18,

            ),)
        ],
      ),
    );
  }
}