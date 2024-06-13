import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddCommentPage extends StatefulWidget {
  final String postId;

  AddCommentPage({required this.postId});

  @override
  _AddCommentPageState createState() => _AddCommentPageState();
}

class _AddCommentPageState extends State<AddCommentPage> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();

  void _addComment() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('comments').add({
        'postId': widget.postId,
        'content': _contentController.text,
        'user': FirebaseAuth.instance.currentUser!.email,
        'timestamp': FieldValue.serverTimestamp(),
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Comment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Comment'),
                validator: (value) => value!.isEmpty ? 'Enter a comment' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addComment,
                child: Text('Add Comment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
