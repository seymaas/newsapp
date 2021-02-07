

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/funcs.dart/firebaseFuncs.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsWidget extends StatefulWidget {
  final String newstitle, newsImage, newsURL, newsDescription, newsSource;
  DetailsWidget(this.newstitle, this.newsImage, this.newsURL,this.newsDescription, this.newsSource);
  @override
  _DetailsWidgetState createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
 
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController notecontroller = TextEditingController();
  bool like,dislike ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                //title and favorite&unfavorite
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //title
                    Expanded(
                      flex: 8,
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          widget.newstitle.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                            fontSize: 19,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    //favorite&unfavorite
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        splashColor: Colors.green[900],
                        onTap: () {
                          if (like == true) {
                            setState(() {
                              like = false;
                              FirebaseFuncs().deleteData(widget.newsURL,"favorites");
                            });
                          } else {
                            setState(() {
                              like = true;
                              dislike = false;
                              FirebaseFuncs().addData(true,widget.newstitle, widget.newsDescription,widget.newsImage,widget.newsSource, widget.newsURL,"favorites",flushBarerrorMsg:"This news has been added to the Favorite List",context: context);
                              FirebaseFuncs().deleteData(widget.newsURL,"unfavorites");
                            });
                          }
                        },
                        child: Icon(
                          Icons.thumb_up_alt_outlined,
                          size: 25,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        splashColor: Colors.red[900],
                        onTap: () {
                          if (dislike == true) {
                            setState(() {
                              dislike = false;
                              FirebaseFuncs().deleteData(widget.newsURL,"unfavorites");
                            });
                          } else {
                            setState(() {
                              dislike = true;
                              like = false;
                              FirebaseFuncs().addData(false,widget.newstitle, widget.newsDescription,widget.newsImage,widget.newsSource, widget.newsURL,"unfavorites",flushBarerrorMsg: "This news has been added to the Unfavorite List.",context: context);
                              FirebaseFuncs().deleteData(widget.newsURL,"favorites");
                            });
                          }
                        },
                        child: Icon(
                          Icons.thumb_down_outlined,
                          size: 25,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Divider(
                    height: 5,
                    thickness: 1,
                    color: Colors.teal,
                  ),
                ),
                Stack(
                  children: [
                    Hero(
                      tag: widget.newsURL,
                                          child: Container(
                        height: 200,
                        width: double.infinity,
                        child: Image.network(
                          widget.newsImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    //source 
                    Positioned(
                        right: 5,
                        top: 5,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.teal[200],
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Text(
                            widget.newsSource,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold),
                          ),
                        ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Divider(
                    height: 5,
                    thickness: 1,
                    color: Colors.teal,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    widget.newsDescription,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: InkWell(
                      onTap: () {
                        _launch(widget.newsURL);
                      },
                      child: Text(
                        "More Information..",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.teal[200],
                            decoration: TextDecoration.underline),
                      )),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(right: 20, top: 20),
                  child: Text(
                    "Comments",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[200],
                        fontSize: 19,
                        decoration: TextDecoration.underline),
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: TextField(
                    maxLines: 3,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: 'Write your comment here',
                      filled: true,
                      hintStyle: TextStyle(fontSize: 12),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: FlatButton(
                    
                    color: Colors.teal[200],
                    padding: EdgeInsets.only(left: 32, right: 32),
                    splashColor: Colors.white,
                    onPressed: () {},
                    child: Text(
                      "Sent".toUpperCase(),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            )));
  }
  
  Future<void> _launch(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  
    
  
  
  
  
}
