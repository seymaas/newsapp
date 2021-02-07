import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:newsapp/funcs/funcs.dart';
import 'package:newsapp/pages/detailsPage.dart';
import 'package:newsapp/widgets/tagWidget.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  //select for page
  bool status = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[200],
      ),
      body:
          //Icons for selection of data to show
          Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            //select favorites collection
                            status = true;
                          });
                        },
                        child: Icon(
                          Icons.thumb_up_alt_outlined,
                          color: status == true?Colors.green: Colors.teal[200],
                        ))),
                Expanded(
                    flex: 1,
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            //selected unfavorites collection
                            status = false;
                          });
                        },
                        child: Icon(Icons.thumb_down_alt_outlined,
                            color: status == false? Colors.red:Colors.teal[200]))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              height: 5,
              thickness: 1,
              color: Colors.teal[200],
            ),
          ),
          //show data
          Container(
            padding: EdgeInsets.only(top: 10),
            child: StreamBuilder(
                //connection with favorites or unfavorites collection-firebase
                stream: FirebaseFirestore.instance
                    .collection(status == true ? "favorites" : "unfavorites")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  //check if there is data in the favorites or unfavorites collection-firebase
                  if (snapshot.data.docs.isEmpty) {
                    //not data for showing
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 50,
                            color: Colors.red[200],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              status == true
                                  ? "No favorites yet ..."
                                  : "No unfavorites yet ...",
                              style: TextStyle(
                                  color: Colors.teal[200], fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  //show data through TagWidget
                  return Container(
                      height: (MediaQuery.of(context).size.height) / 1.6,
                      child: ListView(
                          children: snapshot.data.docs
                              .map((doc) => Hero(
                                    tag: doc["url"],
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailsPage(
                                                          doc["task_title"],
                                                          doc["image"],
                                                          doc["url"],
                                                          doc["description"],
                                                          doc["source"],
                                                          true)));
                                        },
                                        child: Slidable(
                                          actionPane:
                                              SlidableDrawerActionPane(),
                                          secondaryActions: [
                                            IconSlideAction(
                                              color: Colors.red[300],
                                              foregroundColor: Colors.white,
                                              icon: Icons.cancel_outlined,
                                              onTap: () {
                                                //delete data through Slidable
                                                Funcs().deleteData(
                                                    doc["url"],
                                                    status == true
                                                        ? "favorites"
                                                        : "unfavorites",
                                                    flushBarerrorMsg:
                                                        "This news has been deleted to the List.",
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
        ],
      ),
    );
  }
}
