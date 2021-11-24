import 'package:ecommerce_admin_tut/models/products.dart';
import 'package:ecommerce_admin_tut/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 class ProductWidget extends StatelessWidget {
   final ProductModel productModel;
   final VoidCallback onTap;
   final VoidCallback onPressed;

   ProductWidget({
     @required this.productModel,
     @required this.onTap,
     @required this.onPressed,
 });
  @override
  Widget build(BuildContext context) {
    final appProvider=Provider.of<AppProvider>(context);
    return Container(
      margin: EdgeInsets.all(10),
      width: 600,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30)),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child:productModel.picture.isEmpty?Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                ),
              ):Image.network(productModel.picture,),
            ) ,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("  اسم الوجبة :${productModel.name}",
                style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18),),
                Text(" سعر الوجبة :${productModel.price}",
                  style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),),
              ],
            ),
          SizedBox(
              width: 200,),
            IconButton(onPressed:onPressed, icon: Icon(Icons.edit_off,
              size: 40,
              color: Colors.green,)),
            IconButton(onPressed:onTap, icon: Icon(Icons.delete,
              size: 40,
              color: Colors.deepOrange,)),
          ],

          ),
            ),
    );
  }
}
