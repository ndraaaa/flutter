import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostCard extends StatelessWidget {
  final DocumentSnapshot post;

  PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(post['title']),
            subtitle: Text(post['content']),
          ),
          ButtonBar(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.comment),
                onPressed: () {
                  Navigator.pushNamed(context, '/comments', arguments: post.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
