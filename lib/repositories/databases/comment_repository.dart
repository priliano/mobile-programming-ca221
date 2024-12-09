import 'package:myapp/models/comment.dart';
import '../contracts/abs_comment_repository.dart';

class CommentRepository implements AbsCommentRepository {
  final List<Comment> _comments = [];

  @override
  Future<void> addComment(Comment comment) async {
    _comments.add(comment);
  }

  @override
  Future<void> updateComment(Comment comment) async {
    final index = _comments.indexWhere((c) => c.id == comment.id);
    if (index != -1) {
      _comments[index] = comment;
    }
  }

  @override
  Future<void> deleteComment(String commentId) async {
    _comments.removeWhere((c) => c.id == commentId);
  }

  @override
  Future<List<Comment>> getCommentsByMomentId(String momentId) async {
    return _comments.where((c) => c.momentId == momentId).toList();
  }

  @override
  Future<Comment?> getCommentById(String commentId) async {
    // Menggunakan try-catch untuk menangani jika tidak ditemukan
    try {
      return _comments.firstWhere((c) => c.id == commentId);
    } catch (e) {
      return null;  // Mengembalikan null jika tidak ditemukan
    }
  }
}