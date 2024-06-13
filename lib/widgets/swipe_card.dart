import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SwipeCard extends StatelessWidget {
  final DocumentSnapshot animal;

  SwipeCard({required this.animal});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.network(animal['imageUrl'], height: 200, fit: BoxFit.cover),
          SizedBox(height: 10),
          Text(animal['name'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(animal['species'], style: TextStyle(fontSize: 18)),
          Text('${animal['age']} years old', style: TextStyle(fontSize: 16)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(animal['description'], style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
