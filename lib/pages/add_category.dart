import 'package:ecommerce_admin_tut/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCategory extends StatelessWidget {
  var _controller=TextEditingController();
  final _key=GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final appProvide=Provider.of<AppProvider>(context);
    return Scaffold(
        body: Center(
          child: Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.blue,
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                    hintText: 'اكتب صنف الطعام',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30),
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                  color: Colors.purple,
                  onPressed: () {
                    if(_controller.text.isEmpty){
                      _key.currentState.showSnackBar(SnackBar(
                        content: Text('قم باضافة صنف الطعام'),
                      ));
                    }else {
                      appProvide.uploadCategoryDataToStore(_controller.text);
                      appProvide.changeIndex(5);
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    'اضافة',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                RaisedButton(
                  color: Colors.red,
                  onPressed: () {
                    appProvide.changeIndex(5);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    'الغاء',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
      ),
    ),
        ));
  }
}
