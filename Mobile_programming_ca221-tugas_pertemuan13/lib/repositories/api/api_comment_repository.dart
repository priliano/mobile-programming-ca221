import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../../../models/comment.dart';

class ApiCommentRepository {
  final String baseUrl;

  ApiCommentRepository({required this.baseUrl});

  // Get All Comments
  Future<List<Comment>> getAll([String keyword = '']) async {
    final url = Uri.parse('$baseUrl/comments?search=$keyword');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((comment) => Comment.fromMap(comment)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  // Get Comment by ID
  Future<Comment?> getById(String id) async {
    final url = Uri.parse('$baseUrl/comments/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Comment.fromJson(response.body);
    } else {
      throw Exception('Failed to load comment');
    }
  }

  // Create a new Comment
  Future<Comment?> create(Comment newData) async {
    final url = Uri.parse('$baseUrl/comments');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(newData.toDto()),
    );

    if (response.statusCode == 201) {
      return Comment.fromJson(response.body);
    } else {
      throw Exception('Failed to save comment');
    }
  }

  // Update an existing Comment
  Future<bool> update(Comment updatedData) async {
    final url = Uri.parse('$baseUrl/comments/${updatedData.id}');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(updatedData.toDto()),
    );

    return response.statusCode == 200;
  }

  // Delete a Comment
  Future<bool> delete(String id) async {
    final url = Uri.parse('$baseUrl/comments/$id');
    final response = await http.delete(url);

    return response.statusCode == 200;
  }
}
