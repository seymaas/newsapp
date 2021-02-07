import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:newsapp/funcs/funcs.dart';
import 'package:newsapp/pages/detailsPage.dart';
import 'package:newsapp/widgets/tagWidget.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[200],
      ),
      //show data
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: StreamBuilder(
            //connection with readLater collection-firebase
            stream:
                FirebaseFirestore.instance.collection("readLater").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              //check if there is problem about connection
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error : ${snapshot.error}"),
                );
              }
              //wait for connection with Firebase
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              //check if there is data in the readLater collection-firebase
              if (snapshot.data.docs.isEmpty) {
                //not data for showing
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.book,
                        size: 50,
                        color: Colors.teal[200],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "No Read List yet ...",
                          style:
                              TextStyle(color: Colors.teal[200], fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                );
              }
              //show data through TagWidget
              return Container(
                  height: (MediaQuery.of(context).size.height) / 1.4,
                  child: ListView(
                      children: snapshot.data.docs
                          .map((doc) => Hero(
                                tag: doc["url"],
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailsPage(
                                                  doc["task_title"],
                                                  doc["image"],
                                                  doc["url"],
                                                  doc["description"],
                                                  doc["source"],
                                                  false)));
                                    },
                                    child: Slidable(
                                      actionPane: SlidableDrawerActionPane(),
                                      secondaryActions: [
                                        IconSlideAction(
                                          color: Colors.red[300],
                                          foregroundColor: Colors.white,
                                          icon: Icons.cancel_outlined,
                                          onTap: () {
                                            //delete data through Slidable
                                            Funcs().deleteData(
                                                doc["url"], "readLater",
                                                flushBarerrorMsg:
                                                    "This news has been deleted to the Read List.",
                                                context: context);
                                          },
                                        ),
                                      ],
                                      child: TagWidget(
                                          doc["task_title"], doc["image"]),
                                    )),
                              ))
                          .toList()));
            }),
      ),
    );
  }
}
