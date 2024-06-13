import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcard/tcard.dart';

class AnimalSwipePage extends StatefulWidget {
  @override
  _AnimalSwipePageState createState() => _AnimalSwipePageState();
}

class _AnimalSwipePageState extends State<AnimalSwipePage> {
  TCardController _controller = TCardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animal Dating'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('animals').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<DocumentSnapshot> docs = snapshot.data!.docs;

          List<Widget> cards = docs.map((doc) {
            var animal = doc.data() as Map<String, dynamic>;
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
          }).toList();

          return Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: TCard(
                cards: cards,
                controller: _controller,
                onForward: (index, info) {
                  if (info.direction == SwipDirection.Right) {
                    // Add to matches
                  }
                },
                onBack: (index, info) {},
                onEnd: () {
                  print('End of the deck');
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
