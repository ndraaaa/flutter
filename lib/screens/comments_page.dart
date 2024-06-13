import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'add_comment_page.dart';

class CommentsPage extends StatelessWidget {
  final String postId;

  CommentsPage({required this.postId});

  @override
  Widget build(BuildContext context) {
    CollectionReference comments = FirebaseFirestore.instance.collection('comments');

    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: StreamBuilder(
        stream: comments.where('postId', isEqualTo: postId).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var comment = snapshot.data!.docs[index];
              return ListTile(
                title: Text(comment['content']),
                subtitle: Text(comment['user']),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCommentPage(postId: postId)),
          );
        },
        child: Icon(Icons.add_comment),
      ),
    );
  }
}
