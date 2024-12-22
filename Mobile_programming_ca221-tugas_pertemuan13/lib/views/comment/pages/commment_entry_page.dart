import 'package:flutter/material.dart';
import 'package:myapp/models/comment.dart';
import 'package:myapp/repositories/api/api_comment_repository.dart';

class CommentEntryPage extends StatefulWidget {
  static const routeName = '/comment/entry';
  const CommentEntryPage({super.key, this.commentId});
  final String? commentId;

  @override
  State<CommentEntryPage> createState() => _CommentEntryPageState();
}

class _CommentEntryPageState extends State<CommentEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final _dataComment = {};
  bool _isLoading = false;

  final ApiCommentRepository _apiCommentRepository = ApiCommentRepository(baseUrl: 'https://api.example.com');

  @override
  void initState() {
    super.initState();
    if (widget.commentId != null) {
      _loadCommentForEditing(widget.commentId!);
    }
  }

  Future<void> _loadCommentForEditing(String commentId) async {
    try {
      setState(() {
        _isLoading = true;
      });

      final comment = await _apiCommentRepository.getById(commentId);
      if (comment != null) {
        setState(() {
          _dataComment['comment'] = comment.content;
        });
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showDialog('Error', 'Failed to load comment for editing');
    }
  }

  void _saveComment() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      _formKey.currentState!.save();
      final newComment = Comment(
        id: widget.commentId,
        momentId: 'momentIdExample',
        content: _dataComment['comment'],
      );

      try {
        if (widget.commentId == null) {
          final result = await _apiCommentRepository.create(newComment);
          if (result != null) {
            setState(() {
              _isLoading = false;
            });
            Navigator.of(context).pop();
            _showDialog('Success', 'Comment successfully created!');
          }
        } else {
          final result = await _apiCommentRepository.update(newComment);
          if (result) {
            setState(() {
              _isLoading = false;
            });
            Navigator.of(context).pop();
            _showDialog('Success', 'Comment successfully updated!');
          }
        }
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        _showDialog('Error', 'Error: $error');
      }
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.commentId == null ? 'Add Comment' : 'Edit Comment')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                initialValue: _dataComment['comment'],
                decoration: InputDecoration(
                  labelText: 'Comment',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a comment';
                  }
                  return null;
                },
                onSaved: (value) {
                  _dataComment['comment'] = value!;
                },
              ),
              const SizedBox(height: 16),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _saveComment,
                      child: Text(widget.commentId == null ? 'Add Comment' : 'Save Comment'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
