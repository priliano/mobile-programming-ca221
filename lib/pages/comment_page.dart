import 'package:flutter/material.dart';
import '../models/comment.dart';
import 'create_comment_page.dart'; // Pastikan sudah ada CreateCommentPage

class CommentPage extends StatefulWidget {
  final String currentUser; // User saat ini
  final List<Comment> comments;

  const CommentPage({
    super.key,
    required this.currentUser,
    required this.comments,
  });

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late List<Comment> comments;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    comments = widget.comments; // Salin komentar awal
  }

  void _addComment(String content) {
    final newComment = Comment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      author: widget.currentUser,
      content: content,
      createdAt: DateTime.now(),
    );

    setState(() {
      comments.add(newComment);
    });

    // Kembalikan komentar baru ke halaman sebelumnya
    Navigator.pop(context, {'newComment': newComment});
  }

  void _deleteComment(String id) {
    setState(() {
      comments.removeWhere((comment) => comment.id == id);
    });
  }

  void _editComment(String id) async {
    // Cari komentar berdasarkan ID
    final comment = comments.firstWhere((comment) => comment.id == id);
    // Navigasi ke halaman CreateCommentPage dengan data komentar yang ada
    final updatedComment = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateCommentPage(
          initialComment: comment.content,
          initialCreator: comment.author,
          isEditMode: true,
        ),
      ),
    );

    // Jika ada komentar yang diperbarui, lakukan update
    if (updatedComment != null) {
      setState(() {
        comment.content = updatedComment.content;
        comment.createdAt = DateTime.now(); // Menyesuaikan waktu saat edit
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                                'https://www.example.com/profile-picture.jpg'), // Ganti dengan URL foto profil
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Nama pengarang komentar
                                Text(
                                  comment.author,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                // Isi komentar
                                Text(
                                  comment.content,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 8),
                                // Tanggal komentar
                                Text(
                                  comment.formattedDate,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Hanya tampilkan edit dan delete untuk komentar milik pengguna saat ini
                          if (comment.author == widget.currentUser)
                            Column(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    _editComment(comment.id); // Edit comment
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    _deleteComment(comment.id); // Delete comment
                                  },
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: 'Write a comment...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final content = _commentController.text.trim();
                    if (content.isNotEmpty) {
                      _addComment(content);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
