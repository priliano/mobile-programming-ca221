import 'package:flutter/material.dart';
import '../models/animal.dart';

class AnimalCard extends StatelessWidget {
  final Animal animal;
  final Function(String) onDelete;

  const AnimalCard({super.key, required this.animal, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(animal.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(animal.speciesName),
        subtitle: Text(animal.localName),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.black),
          onPressed: () => onDelete(animal.id),
        ),
      ),
    );
  }
}
