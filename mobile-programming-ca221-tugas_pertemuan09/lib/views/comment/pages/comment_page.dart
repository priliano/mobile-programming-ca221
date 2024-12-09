import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models/comment.dart';
import 'package:faker/faker.dart' as faker;
import 'package:nanoid2/nanoid2.dart';

import 'commment_entry_page.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key, required this.momentId});
  final String momentId;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<Comment> _comments = [];
  final _faker = faker.Faker();
  final _dateFormat = DateFormat('dd MMM yyyy');

 @override
void initState() {
  super.initState();
  _comments = List.generate(
    2, // Ganti jumlah menjadi 2
    (index) => Comment(
      id: nanoid(),
      creator: index == 0 ? "Budi" : "Siti", 
      content: index == 0 ? "Fotonya menarik ya" : "Saya suka pemandangannya", 
      createdAt: _faker.date.dateTime(),
      momentId: widget.momentId,
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comment'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: _comments
              .map((comment) => ListTile(
                    title: Text(comment.creator),
                    subtitle: Text(comment.content),
                    leading: const CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://i.pravatar.cc/150'),
                    ),
                    trailing: Text(_dateFormat.format(comment.createdAt)),
                  ))
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return CommentEntryPage(
              onSaved: (newMoment) {},
            );
          }));
        },
        child: const Icon(Icons.comment),
      ),
    );
  }
}
