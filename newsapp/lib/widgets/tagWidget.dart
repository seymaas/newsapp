import 'package:flutter/material.dart';

class TagWidget extends StatefulWidget {
  final String tagTitle, tagImage;
  TagWidget(this.tagTitle, this.tagImage);
  @override
  _TagWidgetState createState() => _TagWidgetState();
}

class _TagWidgetState extends State<TagWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Container(
          margin: EdgeInsets.only(right: 10, left: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: Card(
            child: Row(
              children: <Widget>[
                //image-left side
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    height: 150,
                    width: double.infinity,
                    child: Image.network(
                      widget.tagImage,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                //title-right side
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.tagTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.teal[200],
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
