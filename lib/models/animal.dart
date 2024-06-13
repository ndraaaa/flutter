import 'package:cloud_firestore/cloud_firestore.dart';

class Animal {
  final String id;
  final String name;
  final String species;
  final int age;
  final String imageUrl;
  final String description;

  Animal({
    required this.id,
    required this.name,
    required this.species,
    required this.age,
    required this.imageUrl,
    required this.description,
  });

  factory Animal.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Animal(
      id: doc.id,
      name: data['name'] ?? '',
      species: data['species'] ?? '',
      age: data['age'] ?? 0,
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'species': species,
      'age': age,
      'imageUrl': imageUrl,
      'description': description,
    };
  }
}
