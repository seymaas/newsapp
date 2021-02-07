import 'package:flutter/material.dart';
import 'package:newsapp/widgets/CategoryWidget.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoryPageState();
  }
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[200],
        ),
        body: Column(children: <Widget>[
          //show data through CategoryWidget
          Expanded(
            child: CategoryWidget("General",
                "https://media.istockphoto.com/vectors/hand-holding-megaphone-with-latest-news-megaphone-banner-web-design-vector-id1211620369?k=6&m=1211620369&s=612x612&w=0&h=bGc87VKfWko6csPIsU1IpJKTjRWIkk0B0nmDofkx5uw="),
          ),
          Expanded(
            child: CategoryWidget("Sport",
                "https://media.istockphoto.com/vectors/group-of-people-performing-sports-activities-at-park-doing-yoga-and-vector-id1134302837?b=1&k=6&m=1134302837&s=612x612&w=0&h=_DUzM9hFw2i02LDq9w-G-M5gr4r7etyIaNA6RkIGflY="),
          ),
          Expanded(
            child: CategoryWidget("Economy",
                "https://media.istockphoto.com/vectors/business-team-and-successful-financial-strategy-vector-id1189915287?s=612x612"),
          )
        ]));
  }
}
