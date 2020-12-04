import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wagotel/SinglePostScreen.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List posts = [];
  bool loaded = false;
  _loadData() async {
    String dataURL = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(dataURL);
    setState(() {
      posts = json.decode(response.body);
      loaded = true;
    });
  }

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Posts"),
          backgroundColor: Colors.redAccent,
        ),
        body: loaded ? Container(
            child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
              return CustomCard(posts[index]["id"], posts[index]["userId"],
                posts[index]["title"], posts[index]["body"]);
          },
        )): Center(
          child: CircularProgressIndicator(backgroundColor: Colors.redAccent)
        )
        );
  }
}

class CustomCard extends StatefulWidget {
  final int userId;
  final int id;
  final String title;
  final String body;
  CustomCard(this.id, this.userId, this.title, this.body);

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  int count = 0;

  @override
  void initState() {
    super.initState();

    getCommentsCount();
  }
  getCommentsCount() async{
    String dataURL = "https://jsonplaceholder.typicode.com/comments?postId="+ this.widget.id.toString();
    http.Response response = await http.get(dataURL);
    List comments = json.decode(response.body);
    
      setState(() {
        count = comments.length;
      });
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.red[50],
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SinglePostScreen(this.widget.id) ),
              );
            },
            leading: Icon(Icons.portrait, size: 60),
            title: Text(
              this.widget.title,
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(this.widget.body, style: TextStyle(fontSize: 15.0)),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Comments " + count.toString() ),
            ))
        ],
      ),
    );
  }
}
