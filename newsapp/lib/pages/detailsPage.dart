


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/funcs.dart/firebaseFuncs.dart';
import 'package:newsapp/widgets/detailWidget.dart';

class DetailsPage extends StatefulWidget {
  final String newstitle,newsImage,newsURL,newsDescription,newsSource;
  DetailsPage(this.newstitle,this.newsImage,this.newsURL,this.newsDescription,this.newsSource);
 
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[200],
      ),
      body: DetailsWidget(widget.newstitle,widget.newsImage,widget.newsURL,widget.newsDescription,widget.newsSource),
    );
  }

  
}