import 'dart:io';
import 'package:ecommerce_admin_tut/models/products.dart';
import 'package:ecommerce_admin_tut/providers/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_io/io.dart';

class EditProduct extends StatefulWidget {

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _form=GlobalKey<FormState>();

  final _key=GlobalKey<ScaffoldState>();

  TextEditingController _name=TextEditingController();

  TextEditingController _price=TextEditingController();
@override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final appProvider=Provider.of<AppProvider>(context);
    return  Scaffold(
      key: _key,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80.0,
            horizontal: 300),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.cyan.shade100,
          ),
          height: double.infinity,
          width: double.infinity,
          child: Form(
            key: _form,
            child: Column(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                      appProvider.uploadImage();
                    },
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: appProvider.uploadFile!=null?MemoryImage(appProvider.uploadFile):NetworkImage(appProvider.product.picture),
                            fit: BoxFit.contain
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('...???????? ???????????? ????????????',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),),
                            Icon(Icons.add_a_photo,
                              color: Colors.grey,
                              size: 100,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10),
                  child: TextFormField(
                    validator: (value){
                      if(value.isEmpty||value.length<=4){
                        return '???? ???????????? ?????? ??????????';
                      }
                      return null;
                    },
                    controller: _name,
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: '???????? ?????? ????????????',
                        hintTextDirection: TextDirection.rtl,
                        hintStyle: TextStyle(
                          fontFamily: 'Cairo',
                          color: Colors.black45,
                          fontSize: 20,
                        )
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10),
                  child: TextFormField(
                    controller: _price,
                    validator: (value){
                      final reg=RegExp('([0-9]+(\.[0-9]+)?)');
                      if(!reg.hasMatch(value)||value.isEmpty){
                        return "???????? ?????? ??????????";
                      }
                      return null;
                    },
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: '???????? ?????? ????????????',
                        hintTextDirection: TextDirection.rtl,
                        hintStyle: TextStyle(
                            fontFamily: 'Cairo',
                            color: Colors.black45,
                            fontSize: 20
                        )
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 40,
                      child: RaisedButton(
                        child: Text('??????????',
                          style: TextStyle(
                              color: Colors.white
                          ),),
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: ()async{
                          if(_form.currentState.validate()){
                            if(appProvider.uploadFile==null){
                              _key.currentState.showSnackBar(SnackBar(
                                content: Text('???? ???????????? ????????????'),
                              ));
                            }
                            appProvider.uploadActualDataToStorage(_name.text.trim(), int.parse(_price.text.trim()),prodId: appProvider.product.id);
                            appProvider.changeIndex(5);
                          }
                        },

                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 100,
                      height: 40,
                      child: RaisedButton(
                        child: Text('??????????',
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: ()async{
                          appProvider.changeIndex(5);
                        },

                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
