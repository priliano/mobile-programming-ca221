import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models/comment.dart';
import 'package:faker/faker.dart' as faker;
import 'package:nanoid2/nanoid2.dart';
import 'package:myapp/views/comment/pages/commment_entry_page.dart';
import 'package:myapp/repositories/api/api_comment_repository.dart';

class CommentPage extends StatefulWidget {
  static const routeName = '/comments';
  const CommentPage({super.key, required this.momentId});
  final String momentId;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<Comment> _comments = [];
  final _faker = faker.Faker();
  final _dateFormat = DateFormat('dd MMM yyyy');
  final ApiCommentRepository _apiCommentRepository = ApiCommentRepository(baseUrl: 'https://api.example.com/comments');

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  Future<void> _loadComments() async {
    try {
      final comments = await _apiCommentRepository.getAll();
      setState(() {
        _comments = comments;
      });
    } catch (e) {
      print('Failed to load comments: $e');
    }
  }

  void _deleteComment(String commentId) async {
    try {
      final success = await _apiCommentRepository.delete(commentId);
      if (success) {
        setState(() {
          _comments.removeWhere((comment) => comment.id == commentId);
        });
      }
    } catch (e) {
      print('Failed to delete comment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comment')),
      body: SingleChildScrollView(
        child: Column(
          children: _comments
              .map(
                (comment) => ListTile(
                  title: Text(comment.creatorUsername ?? 'Unknown'),
                  subtitle: Text(comment.content),
                  leading: const CircleAvatar(backgroundImage: NetworkImage('https://i.pravatar.cc/150')),
                  trailing: Text(_dateFormat.format(comment.createdAt)),
                  onLongPress: () => _deleteComment(comment.id!),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      CommentEntryPage.routeName,
                      arguments: comment.id,
                    );
                  },
                ),
              )
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(CommentEntryPage.routeName);
        },
        child: const Icon(Icons.comment),
      ),
    );
  }
}