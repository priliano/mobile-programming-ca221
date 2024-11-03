import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // Contoh URL gambar untuk ditampilkan
  final List<String> _imageUrls = [
    'https://i.pravatar.cc/150?img=1',
    'https://i.pravatar.cc/150?img=2',
    'https://i.pravatar.cc/150?img=3',
    'https://i.pravatar.cc/150?img=4',
    'https://i.pravatar.cc/150?img=5',
    'https://i.pravatar.cc/150?img=6',
    'https://i.pravatar.cc/150?img=7',
    'https://i.pravatar.cc/150?img=8',
    'https://i.pravatar.cc/150?img=9',
    'https://i.pravatar.cc/150?img=10',
    'https://i.pravatar.cc/150?img=11',
    'https://i.pravatar.cc/150?img=12',
    'https://i.pravatar.cc/150?img=13',
    'https://i.pravatar.cc/150?img=14',
    'https://i.pravatar.cc/150?img=15',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: 'Cari moment...',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                // Anda dapat menambahkan logika pencarian di sini jika perlu
                setState(() {
                  // Jika Anda ingin menambahkan logika pencarian, lakukan di sini
                });
              },
            ),
          ),
          Expanded(
            child: _buildImageGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Jumlah kolom dalam grid
        crossAxisSpacing: 4.0, // Spasi antar kolom
        mainAxisSpacing: 4.0, // Spasi antar baris
      ),
      itemCount: _imageUrls.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(2.0), // Jarak antar gambar
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300), // Garis tepi pada gambar
            borderRadius: BorderRadius.circular(8.0), // Membuat sudut melengkung
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              _imageUrls[index],
              fit: BoxFit.cover, // Mengisi kontainer tanpa merusak rasio
            ),
          ),
        );
      },
    );
  }
}
