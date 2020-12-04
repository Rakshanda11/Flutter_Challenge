import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SinglePostScreen extends StatefulWidget {
  final int postId;
  SinglePostScreen(this.postId);
  @override
  _SinglePostScreenState createState() => _SinglePostScreenState();
}

class _SinglePostScreenState extends State<SinglePostScreen> {
  List comments = [];
  var post;
  bool loaded = false;
  _loadData() async {
    String dataURL1 = 'https://jsonplaceholder.typicode.com/comments?postId=' +
        widget.postId.toString();
    String dataURL2 = 'https://jsonplaceholder.typicode.com/posts/' +
        widget.postId.toString();
    http.Response response1 = await http.get(dataURL1);
    http.Response response2 = await http.get(dataURL2);
    setState(() {
      comments = json.decode(response1.body);
      loaded = true;
      post = json.decode(response2.body);
    });
  }

  @override
  void initState() {
    super.initState();
    if (!loaded) _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Post"),
          backgroundColor: Colors.redAccent,
        ),
        body: loaded
            ? SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(),
                  child: Column(
                    children: <Widget>[
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.red[50],
                        child: ListTile(
                          leading: Icon(Icons.portrait, size: 60),
                          title: Text(
                            post["title"].toString(),
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(post["body"].toString(),
                              style: TextStyle(fontSize: 15.0)),
                        ),
                      ),
                      ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          return CustomCommentCard(
                              comments[index]["id"],
                              comments[index]["name"],
                              comments[index]["email"],
                              comments[index]["body"]);
                        },
                      )
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                    backgroundColor: Colors.redAccent)));
  }
}

class CustomCommentCard extends StatelessWidget {
  final int id;
  final String name;
  final String email;
  final String body;
  CustomCommentCard(this.id, this.name, this.email, this.body);

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        children: <Widget>[
          ListTile(
            leading: Text(
              "Id: " + this.id.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
              child: new Text(
                "Email: " + this.email,
                style: TextStyle(color: Colors.grey),
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(60, 0, 20, 20),
            child: new Text("Name: " + this.name,
                style: TextStyle(fontSize: 15.0, fontStyle: FontStyle.italic)),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(65, 20, 20, 20),
              child: new Text(this.body, style: TextStyle(fontSize: 15.0)))
        ],
      ),
    );
  }
}
