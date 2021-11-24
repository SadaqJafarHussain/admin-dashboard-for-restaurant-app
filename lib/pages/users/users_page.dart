import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_tut/widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void dispose() {
    super.dispose();
  }
  final fireStore=FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
          PageHeader(
            text: 'الزبائن',
          ),
              SizedBox(
                height: 50,
                child: Card(
                  elevation: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    textDirection: TextDirection.rtl,
                    children: [
                       SizedBox(
                           width: 100,
                           child: Center(child: Text("اسم الزبون",
                           style: TextStyle(
                               color: Colors.black45,
                             fontFamily: "Cairo",
                             fontWeight: FontWeight.bold
                           ),))),
                      SizedBox(
                          width: 120,
                          child: Center(child: Text("االبريد الالكتروني",
                            style: TextStyle(
                              color: Colors.black45,
                                fontFamily: "Cairo",
                                fontWeight: FontWeight.bold
                            ),))),
                      SizedBox(
                          width: 100,
                          child: Center(child: Text("رقم الهاتف",
                            style: TextStyle(
                                color: Colors.black45,
                                fontFamily: "Cairo",
                                fontWeight: FontWeight.bold
                            ),))),
                    ],
                  ),
                ),
              ),
             StreamBuilder<QuerySnapshot>(
                 stream: fireStore.collection("users").snapshots(),
                 builder: (context,snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if(snapshot.data.docs.length==0){
                    return Center(
                      child: Text('لايوجد مستحدمين'),
                    );
                  }
                  return SizedBox(
                    height: 500,
                    child: ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context,index){
                          DocumentSnapshot doc=snapshot.data.docs[index];
                      return  Container(
                        margin: EdgeInsets.all(8),
                        height: 50,
                        decoration:   BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          textDirection: TextDirection.rtl,
                          children: [
                              SizedBox(
                                  width: 200,
                                  child: Center(child: Text(doc.data()['name'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),))),
                            SizedBox(
                                width: 200,
                                child: Center(child: Text(doc.data()['email'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ))),
                            SizedBox(
                                width: 200,
                                child: Center(child: Text(doc.data()['phone'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),))),
                          ],
                        ),
                      );
                    }),
                  );
             }),
                ],
              ),
            );
  }
}
