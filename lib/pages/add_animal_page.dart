import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/animal.dart';

class AddAnimalPage extends StatelessWidget {
  final Function(Animal) onAddAnimal;

  AddAnimalPage({super.key, required this.onAddAnimal});

  final _formKey = GlobalKey<FormState>();

  final _speciesController = TextEditingController();
  final _localNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Hewan Baru'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _speciesController,
                  decoration: const InputDecoration(labelText: 'Nama Spesies'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan masukkan nama spesies';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _localNameController,
                  decoration: const InputDecoration(labelText: 'Nama Lokal'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan masukkan nama lokal';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Deskripsi'),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan masukkan deskripsi';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _imageController,
                  decoration: const InputDecoration(labelText: 'URL Gambar'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan masukkan URL gambar';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newAnimal = Animal(
                        id: const Uuid().v4(),
                        speciesName: _speciesController.text,
                        localName: _localNameController.text,
                        description: _descriptionController.text,
                        imageUrl: _imageController.text,
                      );

                      // Memanggil fungsi callback untuk menambahkan data
                      onAddAnimal(newAnimal);

                      // Kembali ke halaman sebelumnya
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Tambah Hewan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
