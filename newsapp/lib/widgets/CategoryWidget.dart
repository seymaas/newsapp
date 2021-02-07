import 'package:flutter/material.dart';
import 'package:newsapp/pages/tagPage.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class CategoryWidget extends StatefulWidget {
  final String categoryTitle, categoryImage;
  CategoryWidget(this.categoryTitle, this.categoryImage);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    //to go TagPage with category title
    return InkWell(
      onTap: () => pushNewScreen(
        context,
        screen: TagPage(widget.categoryTitle),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
        child: Card(
          child: Column(
            children: <Widget>[
              //image
              Container(
                height: MediaQuery.of(context).size.height / 6,
                width: double.infinity,
                child: Image.network(
                  widget.categoryImage,
                  fit: BoxFit.fill,
                ),
              ),

              //title
              Container(
                  child: Container(
                padding: EdgeInsets.all(5),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    widget.categoryTitle,
                    style: TextStyle(
                      color: Colors.teal[200],
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

