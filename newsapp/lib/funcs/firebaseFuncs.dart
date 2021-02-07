import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FirebaseFuncs {
  final databaseReference = FirebaseFirestore.instance;

//add new data in firebase for favorites||unfavorites||readlater collection
  Future addData(
      bool status, String title, description, image, source, url, collection,
      {flushBarerrorMsg, context}) {
    CollectionReference collectionReference =
        databaseReference.collection(collection);
    showFlushbarFun(Colors.teal[200], flushBarerrorMsg, context);
    return collectionReference
        .doc()
        .set({
          'task_title': title,
          'description': description,
          'image': image,
          'source': source,
          'url': url,
          'status': status
        })
        .then((value) => print("Data Added"))
        .catchError((error) => print("Failed to add data"));
  }

//delete selected data in firebase for favorites||unfavorites||readlater collection
  Future<void> deleteData(String url, collection,
      {flushBarerrorMsg, context}) async {
    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection(collection).get();
    if (collection == "readLater")
      showFlushbarFun(Colors.teal[200], flushBarerrorMsg, context);
    snap.docs.forEach((document) {
      if (document.get("url") == url) {
        databaseReference.collection(collection).doc(document.id).delete();
      }
    });
  }

  showFlushbarFun(Color color, String flushBarerrorMsg, BuildContext context) =>
      Flushbar(
        backgroundColor: Colors.white,
        messageText: Text(
          flushBarerrorMsg,
          style: TextStyle(color: Colors.teal[200]),
        ),
        duration: Duration(seconds: 1),
        margin: EdgeInsets.all(8),
        borderRadius: 8,
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);
}
