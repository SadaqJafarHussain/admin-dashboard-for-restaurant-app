import 'dart:typed_data';
import 'package:ecommerce_admin_tut/models/products.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:html';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';

class AppProvider with ChangeNotifier {
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  String productId='';
  var categoryId='';
  var uuid=new Uuid();
  String image;
  var showCategoryId='';
  String networkImage='';
  double revenue = 0;
  int _index=0;
  Uint8List uploadFile;
  ProductModel product;

  get index{
    return _index;
  }
   changeIndex(int i,{ProductModel parameter}){
    product=parameter;
    notifyListeners();
    _index=i;
    notifyListeners();
   }
   changeShowCategoryId(String id){
    showCategoryId=id;
    notifyListeners();
   }
   changeCategoryId(String id){
    categoryId=id;
    notifyListeners();
   }
  uploadCategoryDataToStore(String category){
    final id=DateTime.now();
    firestore.collection('categories').doc(id.toString()).set({
      'id':id.toString(),
      'category':category,
    });
    categoryId=id.toString();
    notifyListeners();
  }
   uploadDemoDataToStore(){
    final id=DateTime.now();
    firestore.collection('products').doc(id.toString()).set({
      'id':id,
      'categoryId':categoryId,
      'name':'بركر بالدجاج',
      'image':'',
      'price':'2000'
    });
    productId=id.toString();
    notifyListeners();

  }
  uploadImage()async{
   FilePickerResult result;
   result=await FilePicker.platform.pickFiles(
     type: FileType.image,
     allowedExtensions: ['png','jpg','jpeg'],
   );

   if(result!=null){
     uploadFile=result.files.single.bytes;
     notifyListeners();
   }
  }

  uploadActualDataToStorage(String name,int price,{String prodId})async{
   if(prodId==null){
     Reference reference=FirebaseStorage.instance.ref().child(productId);
     UploadTask uploadTask=reference.putData(uploadFile);
     uploadTask.whenComplete(()async {
       image=await uploadTask.snapshot.ref.getDownloadURL();
       notifyListeners();
       firestore.collection('products').doc(productId).update({
         'image':image,
         'name':name,
         'price':price.toString(),
         'categoryId':categoryId,
         "timeStamp":DateTime.now(),
       });
     });
   }else{
     Reference reference=FirebaseStorage.instance.ref().child(prodId);
     UploadTask uploadTask=reference.putData(uploadFile);
     uploadTask.whenComplete(()async {
       image=await uploadTask.snapshot.ref.getDownloadURL();
       notifyListeners();
       firestore.collection('products').doc(prodId).update({
         'image':image,
         'name':name,
         'price':price.toString(),
         'categoryId':categoryId,
         "timeStamp":DateTime.now(),
       });
     });
   }
  }
  clear(){
    image=null;
    notifyListeners();
  }
deleteDoc(dynamic id,String collection){
  FirebaseFirestore.instance
      .collection(collection)
      .where("id", isEqualTo : id)
      .get().then((value){
    value.docs.forEach((element) {
      FirebaseFirestore.instance.collection(collection).doc(element.id).delete().then((value){
        print("Success!");
      });
    });
  });
}
deleteFromStorage(String id){
  var desertRef = FirebaseStorage.instance.ref().child(id);
  // Delete the file
  desertRef.delete();
}
}
