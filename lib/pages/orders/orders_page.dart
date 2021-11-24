import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Widget> widgets;
  int index=0;

  bool _new=true;
  bool _kit=false;
  bool _deliver=false;
  bool _rejected=false;
  @override
  void initState() {
    super.initState();
    widgets=[
      _newOrders(),
      _kitchen(),
      _delivering(),
      _rejectedOrders()
    ];
  }
    @override
    void dispose() {
      super.dispose();
    }
    var _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
            child: Column(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Container(
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _new?Colors.deepOrange: Colors.blueAccent,
                        ),
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              index=0;
                              _new=true;
                              _kit=false;
                              _deliver=false;
                              _rejected=false;
                            });
                          },
                          child: Text("الطلبات الجديده",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            fontFamily: "Cairo"
                          ),),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: _kit?Colors.deepOrange: Colors.blueAccent,
                          ),
                          child: TextButton(onPressed: (){
                            setState(() {
                              index=1;
                              _new=false;
                              _kit=true;
                              _deliver=false;
                              _rejected=false;
                            });
                          }, child: Text("في المطبخ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "Cairo"
                          ),))),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:_deliver?Colors.deepOrange: Colors.blueAccent,
                          ),
                          child: TextButton(onPressed: (){
                            setState(() {
                              index=2;
                              _new=false;
                              _kit=false;
                              _deliver=true;
                              _rejected=false;
                            });
                          }, child: Text("جاري التوصيل",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              fontFamily: "Cairo"
                            ),))),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _rejected?Colors.deepOrange: Colors.blueAccent,
                        ),
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              index=3;
                              _new=false;
                              _kit=false;
                              _deliver=false;
                              _rejected=true;
                            });
                          },
                          child: Text("الطلبات المرفوضه",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: "Cairo"
                            ),),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                widgets[index],

                ])),
      );
    }
    Widget _buildTile(DocumentSnapshot doc,String collection,String mainCollection,String ordersCollection){
      return Directionality (
        textDirection: TextDirection.rtl,
        child: ExpansionTile(
          collapsedIconColor: Colors.deepOrange,
          textColor: Colors.green,
          collapsedBackgroundColor: Colors.blueGrey,
          collapsedTextColor: Colors.white,
          childrenPadding: EdgeInsets.all(16),
          leading: Icon(Icons.person,
          size: 40,
          color: Colors.deepOrange,),
          title: Text("  اسم الزبون      :  ${doc.data()["userName"]}"),
            subtitle: Row(
              children: [
                Text(" رقم هاتف الزبون  :   ${doc.data()["userPhone"]}"),
                SizedBox(
                  width: 40,
                ),
                Text(" رقم الطلب  :   ${doc.data()["orderNumber"].toString()}"),
                SizedBox(
                  width: 250,
                ),
              mainCollection=="deliveryUserOrders"?
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Row(
                      children: [
                        Text("جاري التوصيل .....",style: TextStyle(
                          fontSize: 20,
                          color: Colors.yellow
                        ),),
                      ],
                    ),
                  )
                  :  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   SizedBox(
                     width: 100,
                     child:_new ||_rejected? RaisedButton(
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10),
                       ),
                       onPressed: ()async{
                         await  FirebaseFirestore.instance.collection(mainCollection).doc(doc.id).delete();
                         await  FirebaseFirestore.instance.collection("newOrders").where("userId",isEqualTo: doc.id).get().then((value) {
                         value.docs.forEach((element) {
                           FirebaseFirestore.instance.collection("newOrders").doc(element.id).delete();
                         });
                              });

                         },
                       color: Colors.red,
                     child: Text("رفض الطلب",
                     style: TextStyle(
                       color: Colors.white,
                     ),),):Text(""),
                   ),
                    SizedBox(width: 20,
                    ),
                    SizedBox(
                      width: 100,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: ()async{
                          if(collection=="deliveryUserOrders"){
                            _showSheet(context,doc);
                          }
                          else {
                            await FirebaseFirestore.instance.collection('orderStatus').where("userId",isEqualTo: doc.id).get().then((value) => {
                              value.docs.forEach((element) async{
                               await FirebaseFirestore.instance.collection('orderStatus').doc(element.id).update({
                              "status":"cooking",
                            });
                            })
                            });
                            await  FirebaseFirestore.instance.collection("newOrders").where("userId",isEqualTo: doc.id).get().then((value) {
                              value.docs.forEach((element) async{
                              await  FirebaseFirestore.instance.collection("kitchenOrders").doc(element.id).set({
                                  "userId": element.data()["userId"],
                                  "orderName": element.data()["orderName"],
                                  "id": element.data()["id"],
                                  "price": element.data()["price"],
                                  "image": element.data()["image"],
                                  "quantity": element.data()["quantity"],
                                  "orderStatus":"cooking"
                                });
                              await  FirebaseFirestore.instance.collection("newOrders").doc(element.id).delete();
                              });
                            });

                            await FirebaseFirestore.instance.collection(
                                collection).doc(doc.id).set({
                              "address":doc.data()["address"],
                              "lat":doc.data()["lat"],
                              "price":doc.data()["price"],
                              "long":doc.data()["long"],
                              "orderNumber": doc.data()["orderNumber"],
                              "timeStamp": doc.data()["timeStamp"],
                              "userId": doc.data()["userId"],
                              "userName": doc.data()["userName"],
                              "userPhone": doc.data()["userPhone"],
                            }).then((_) {
                              FirebaseFirestore.instance.collection(
                                  mainCollection).doc(doc.id).delete();
                            });
                          }
                        },
                        color: Colors.green,
                        child: Text(_kit?"تحويل للتوصيل":_new?"تحويل للمطبخ":_rejected?"تحويل للتوصيل":"تم التوصيل",
                          style: TextStyle(
                            color: Colors.white,
                          ),),),
                    ),
                  ],
                ),
                SizedBox(
                  width: 60,
                ),
              ],
            ),
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection(ordersCollection).where("userId",isEqualTo: doc.data()["userId"]).snapshots(),
              builder: (context,snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(snapshot.data.docs.length==0){
                  return Center(
                    child: Text("لاتوجد طلبات"),
                  );
                }
                return SizedBox(
                  height: 300,
                  child: ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context,index){
                        DocumentSnapshot document=snapshot.data.docs[index];
                        return Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListTile(
                            leading: Image.network(document.data()["image"]),
                            title: Text(document.data()["orderName"]),
                            subtitle: Row(
                              textDirection: TextDirection.rtl,
                              children: [
                                Text("السعر : ${document.data()["price"]}",
                                style: TextStyle(
                                  color: Colors.deepOrange,
                                ),),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("الكميه : ${document.data()["quantity"].toString()}"),
                              ],
                            ),

                          ),
                        );
                      }),
                );
              },

            ),
          ],
        ),
      );
    }

    Widget _newOrders(){
      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("newUserOrders").snapshots(),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if(snapshot.data.docs.length==0){
              return Center(
                child: Text("لاتوجد طلبات"),
              );
            }
            return SizedBox(
              height: 500,
              child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context,index){
                    DocumentSnapshot doc=snapshot.data.docs[index];
                    return _buildTile(doc,"kitchenUserOrders","newUserOrders","newOrders");
                  }),
            );
          });
    }
    Widget _kitchen(){
      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("kitchenUserOrders").snapshots(),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if(snapshot.data.docs.length==0){
              return Center(
                child: Text("لاتوجد طلبات"),
              );
            }
            return SizedBox(
              height: 500,
              child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context,index){
                    DocumentSnapshot doc=snapshot.data.docs[index];
                    return _buildTile(doc,"deliveryUserOrders","kitchenUserOrders","kitchenOrders");
                  }),
            );
          });
    }

    Widget _delivering(){
      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("deliveryUserOrders").snapshots(),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if(snapshot.data.docs.length==0){
              return Center(
                child: Text("لاتوجد طلبات"),
              );
            }
            return SizedBox(
              height: 500,
              child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context,index){
                    DocumentSnapshot doc=snapshot.data.docs[index];
                    return _buildTile(doc,"deliveredOrders","deliveryUserOrders","deliverOrders");
                  }),
            );
          });
    }

  Widget _rejectedOrders(){
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("rejectedOrders").snapshots(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.data.docs.length==0){
            return Center(
              child: Text("لاتوجد طلبات"),
            );
          }
          return SizedBox(
            height: 500,
            child: ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context,index){
                  DocumentSnapshot doc=snapshot.data.docs[index];
                  return _buildTile(doc,"deliveryUserOrders","rejectedOrders","rejectedOrders");
                }),
          );
        });
  }


  _showSheet(BuildContext context,DocumentSnapshot doc){
      showModalBottomSheet(
          context: context, builder: (ctx){
        return  Padding(
          padding: const EdgeInsets.only(right: 1300),
          child: Container(
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),)
                ),
                child: Column(
                  children: [
                    Center(
                      child: Text("اختر عامل للتوصيل",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Cairo",

                      ),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,),
                    ),
                    Divider(),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection("deliveryMen").snapshots(),
                        builder: (context,snapshot){
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if(snapshot.data.docs.length==0){
                        return Center(
                          child: Text("لا يوجد عامل لديك"),
                        );
                      }
                      return SizedBox(
                        height: 320,
                        child: ListView.builder(
                          shrinkWrap: true,
                          dragStartBehavior: DragStartBehavior.start,
                          physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context,index){
                            DocumentSnapshot document=snapshot.data.docs[index];
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  onTap: ()async{
                                    await FirebaseFirestore.instance.collection('orderStatus').where("userId",isEqualTo: doc.id).get().then((value) => {
                                    value.docs.forEach((element) async{
                                    await FirebaseFirestore.instance.collection('orderStatus').doc(element.id).update({
                                    "status":"delivering",
                                    });
                                    })
                                    });
                                    await  FirebaseFirestore.instance.collection("kitchenOrders").where("userId",isEqualTo: doc.id).get().then((value) {
                                      value.docs.forEach((element) async{
                                        await  FirebaseFirestore.instance.collection("deliverOrders").doc(element.id).set({
                                          "userId": element.data()["userId"],
                                          "orderName": element.data()["orderName"],
                                          "id": element.data()["id"],
                                          "price": element.data()["price"],
                                          "image": element.data()["image"],
                                          "quantity": element.data()["quantity"],
                                          "orderStatus":"delivering"
                                        });
                                        await  FirebaseFirestore.instance.collection("kitchenOrders").doc(element.id).delete();
                                      });
                                    });
                                    await FirebaseFirestore.instance.collection(
                                        "deliveryUserOrders").doc(doc.id).set({
                                      "address":doc.data()["address"],
                                      "lat":doc.data()["lat"],
                                      "long":doc.data()["long"],
                                      "price":doc.data()["price"],
                                      "deliveryMan":document.data()["id"],
                                      "deliveryName":document.data()["name"],
                                      "deliveryPhone":document.data()["phone"],
                                      "orderNumber": doc.data()["orderNumber"],
                                      "timeStamp": doc.data()["timeStamp"],
                                      "userId": doc.data()["userId"],
                                      "userName": doc.data()["userName"],
                                      "userPhone": doc.data()["userPhone"],
                                    }).then((_) {
                                      FirebaseFirestore.instance.collection(
                                          "kitchenUserOrders").doc(doc.id).delete();
                                      Navigator.pop(context);
                                    });
                                  },
                                leading: Icon(Icons.person,
                                size: 40,),
                                  title: Text(document.data()["name"],
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),),
                                  subtitle: Text(document.data()["phone"]),
                                ),
                              ),
                            );
                        }),
                      );
                    }),
                  ],
                ),
                ),
        );
            }
        );
    }
  }

