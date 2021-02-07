import 'package:flutter/material.dart';
import 'package:newsapp/widgets/detailsWidget.dart';

class DetailsPage extends StatefulWidget {
  final String newstitle, newsImage, newsURL, newsDescription, newsSource;
  final bool isfavoritepage;
  DetailsPage(this.newstitle, this.newsImage, this.newsURL,
      this.newsDescription, this.newsSource, this.isfavoritepage);

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
      //show data through DetailsWidget
      body: DetailsWidget(widget.newstitle, widget.newsImage, widget.newsURL,
          widget.newsDescription, widget.newsSource, widget.isfavoritepage),
    );
  }
}
