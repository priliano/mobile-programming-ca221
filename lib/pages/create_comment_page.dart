import 'package:flutter/material.dart';
import '../models/comment.dart';

class CreateCommentPage extends StatefulWidget {
  final String? initialComment;
  final String? initialCreator;
  final bool isEditMode;

  CreateCommentPage({
    super.key,
    this.initialComment,
    this.initialCreator,
    this.isEditMode = false,
  });

  @override
  State<CreateCommentPage> createState() => _CreateCommentPageState();
}

class _CreateCommentPageState extends State<CreateCommentPage> {
  late TextEditingController _creatorController;
  late TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _creatorController = TextEditingController(text: widget.initialCreator);
    _commentController = TextEditingController(text: widget.initialComment);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditMode ? 'Edit Comment' : 'Create Comment'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Menutup halaman saat tombol back ditekan
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Menyembunyikan keyboard saat tap di luar input
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Creator',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _creatorController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  hintText: 'Your name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Comment',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _commentController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Write your comment',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.attach_file),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Attachment feature not implemented yet!'),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF795548),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        final creator = _creatorController.text.trim();
                        final commentContent = _commentController.text.trim();

                        if (creator.isEmpty || commentContent.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill in all fields!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        final newComment = Comment(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          author: creator,
                          content: commentContent,
                          createdAt: DateTime.now(),
                        );

                        Navigator.pop(context, newComment);
                      },
                      child: Text(widget.isEditMode ? 'Update' : 'Send'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        side: BorderSide(
                          color: Colors.brown.shade300,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context); // Batalkan dan kembali
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.brown),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
