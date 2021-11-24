import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_tut/models/categories.dart';
import 'package:ecommerce_admin_tut/models/products.dart';
import 'package:ecommerce_admin_tut/providers/app_provider.dart';
import 'package:ecommerce_admin_tut/widgets/categoryWidget.dart';
import 'package:ecommerce_admin_tut/widgets/page_header.dart';
import 'package:ecommerce_admin_tut/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:responsive_table/responsive_table.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  bool productsExists=false;
  String categoryId='';
  String showId='';

  List<Widget> products=[];

  final fireStore=FirebaseFirestore.instance;
  @override
  void dispose() {
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
  }
  @override


  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Card(
                elevation: 2,
                shadowColor: Colors.black,
                clipBehavior: Clip.none,
                child: RaisedButton.icon(
                  color: Colors.blue,
                    onPressed: () {
                      Provider.of<AppProvider>(context, listen: false)
                          .changeIndex(6);
                    },
                    icon: Icon(Icons.add,
                    color: Colors.white,),
                    label: Text("اضف صنف جديد",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Cairo'
                    ),)),
              ),
             Align(
               alignment: Alignment.centerRight,
               child: StreamBuilder(
                   stream: fireStore.collection('categories').snapshots(),
                   builder:(context,snapshot){
                     if(snapshot.connectionState==ConnectionState.waiting){
                       return Center(
                         child: CircularProgressIndicator(),
                       );
                     }else if(snapshot.data.documents.length==0){
                       return Center(child: Text('لاتوجود اصناف طعام'),);
                     }
                     return Container(
                       height: 100,
                       child: Directionality(
                         textDirection: TextDirection.rtl,
                         child: ListView.builder(
                             scrollDirection: Axis.horizontal,
                             itemCount: snapshot.data.documents.length,
                             itemBuilder: (context,index){
                               return GestureDetector(
                                 onTap: (){
                                   setState(() {
                                     categoryId=snapshot.data.docs[index].id.toString();
                                     appProvider.changeShowCategoryId(snapshot.data.docs[index].id.toString());
                                   });
                                 },
                                 child: CategoryWidget(category:CategoriesModel.fromSnapshot(
                                   snapshot.data.documents[index],
                                 ),),
                               );
                             }),
                       ),
                     );
                   } ),
             ),
             categoryId.isNotEmpty? Card(
                elevation: 2,
                shadowColor: Colors.black,
                clipBehavior: Clip.none,
                child: RaisedButton.icon(
                  color: Colors.blue,
                            onPressed: () {
                              Provider.of<AppProvider>(context, listen: false)
                                  .changeCategoryId(categoryId);
                              Provider.of<AppProvider>(context, listen: false)
                                  .changeIndex(4);
                            },
                            icon: Icon(Icons.add,
                            color: Colors.white,),
                            label: Text("اضف عنصر جديد",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Cairo',
                            ),)),
              ):Text(''),
              StreamBuilder<QuerySnapshot>(
                  stream:categoryId.isNotEmpty? fireStore.collection('products').where('categoryId',isEqualTo: categoryId).snapshots():
                  fireStore.collection('products').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } if (snapshot.data.documents.length==0){
                      return Center(
                        child: Text('ليس هناك وجبات'),
                      );
                    }
                    else {
                      return Container(
                        width: 600,
                        height: 500,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot doc = snapshot.data.docs[index];
                              return  ProductWidget(
                                  productModel: ProductModel.fromSnapshot(doc),
                              onTap: (){
                                    appProvider.deleteDoc(doc.data()["id"], "products");
                                    appProvider.deleteFromStorage(doc.id);
                              },
                              onPressed: (){
                                    appProvider.changeIndex(7, parameter: ProductModel.fromSnapshot(doc));
                              },);
                            }
                        ),
                      );
                    }
                  }),
            ]),
      ),
    );
  }
}
