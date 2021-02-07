import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/entity/api.dart';
import 'package:newsapp/funcs/funcs.dart';
import 'package:newsapp/pages/detailsPage.dart';
import 'package:newsapp/widgets/tagWidget.dart';

class TagPage extends StatefulWidget {
  final String categoryTitle;
  TagPage(this.categoryTitle);
  @override
  State<StatefulWidget> createState() {
    return _TagPageState();
  }
}

class _TagPageState extends State<TagPage> {
  StreamController<Category> categoryController =
      StreamController<Category>.broadcast();

  final databaseReference = FirebaseFirestore.instance;

  @override
  void initState() {
    //function for call api
    callapi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //selected category
        title: Text(widget.categoryTitle.toUpperCase()),
        backgroundColor: Colors.teal[200],
      ),
      body: StreamBuilder(
          stream: categoryController.stream,
          initialData: null,
          builder: (context, data) {
            //wait for data from the API
            if (data.hasData) {
              Category category = data.data;

              //check if there is data in the API
              if (category.result.length > 0) {
                return ListView.builder(
                    itemCount: category.result.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        secondaryActions: [
                          IconSlideAction(
                            color: Colors.teal,
                            foregroundColor: Colors.white,
                            icon: Icons.book,
                            onTap: () {
                              //add data to Firebase with Slidable
                              Funcs().addData(
                                  false,
                                  category.result[index].name,
                                  category.result[index].description,
                                  category.result[index].image,
                                  category.result[index].source,
                                  category.result[index].url,
                                  "readLater",
                                  flushBarerrorMsg:
                                      "This news has been added to the Read List.",
                                  context: context);
                            },
                          ),
                        ],
                        actionPane: SlidableDrawerActionPane(),
                        //go to DetailPage with animation
                        child: Hero(
                          tag: category.result[index].url,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailsPage(
                                            category.result[index].name,
                                            category.result[index].image,
                                            category.result[index].url,
                                            category.result[index].description,
                                            category.result[index].source,
                                            false)));
                              },
                              //show datas through TagWidget
                              child: TagWidget(category.result[index].name,
                                  category.result[index].image)),
                        ),
                      );
                    });
              } else {
                return Center(child: Text("Not Found."));
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Future<dynamic> callapi() async {
    var url = "https://api.collectapi.com/news/getNews?country=tr&tag=" +
        widget.categoryTitle.toLowerCase();

    var headers = {
      "authorization": "apikey 7bY9oaq0xPzdO6zR0950e1:12bT9GD8lK6I5mG35aRY1R",
      "content-type": "application/json"
    };
    var response = await http.get(url, headers: headers);
    Category name = Category.fromJson(jsonDecode(response.body));
    categoryController.sink.add(name);
  }
}
