import 'package:flutter/material.dart';
import '../models/animal.dart';
import 'add_animal_page.dart';
import '../widgets/animal_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Animal> animals = [];

  void addAnimal(Animal animal) {
    setState(() {
      animals.add(animal);
    });
  }

  void deleteAnimal(String id) {
    setState(() {
      animals.removeWhere((animal) => animal.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animal Data Management'),
      ),
      body: animals.isEmpty
          ? const Center(child: Text('No animals added yet.'))
          : ListView.builder(
              itemCount: animals.length,
              itemBuilder: (context, index) {
                return AnimalCard(
                  animal: animals[index],
                  onDelete: deleteAnimal,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddAnimalPage(
                onAddAnimal: addAnimal,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
