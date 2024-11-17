import 'package:flutter/material.dart';
import 'package:myapp/resources/dimentions.dart';
import 'package:myapp/widgets/post_action.dart';
import 'package:myapp/widgets/post_title.dart';

import '../models/moment.dart';
import '../models/comment.dart';
import '../pages/comment_page.dart';

class PostItem extends StatefulWidget {
  const PostItem({
    super.key,
    required this.moment,
  });

  final Moment moment;

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  int commentCount = 0;
  List<Comment> comments = [];

  @override
  void initState() {
    super.initState();
    commentCount = widget.moment.commentCount;

    // Dummy komentar
    comments = [
      Comment(
        id: '1',
        author: 'User123',
        content: 'Komentar pertama!',
        createdAt: DateTime.now(),
      ),
      Comment(
        id: '2',
        author: 'User456',
        content: 'Komentar kedua!',
        createdAt: DateTime.now(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: largeSize,
          vertical: mediumSize,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(extraLargeSize),
          image: DecorationImage(
            image: NetworkImage(widget.moment.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PostTitle(
              creator: widget.moment.creator,
              location: widget.moment.location,
            ),
            Padding(
              padding: const EdgeInsets.all(smallSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      PostAction(
                        icon: 'assets/icons/fi-br-heart.svg',
                        label: widget.moment.likeCount.toString(),
                      ),
                      PostAction(
                        icon: 'assets/icons/fi-br-comment.svg',
                        label: commentCount.toString(),
                        onPressed: () async {
                          // Navigasi ke halaman komentar
                          final result = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CommentPage(
                                currentUser: 'User123',
                                comments: comments,
                              ),
                            ),
                          );

                          // Periksa apakah ada komentar baru
                          if (result != null && result['newComment'] != null) {
                            final newComment = result['newComment'] as Comment;

                            // Tambahkan hanya jika komentar belum ada di daftar
                            if (!comments.any((comment) => comment.id == newComment.id)) {
                              setState(() {
                                comments.add(newComment);
                                commentCount = comments.length;
                              });
                            }
                          }
                        },
                      ),
                      PostAction(
                        icon: 'assets/icons/fi-br-bookmark.svg',
                        label: widget.moment.bookmarkCount.toString(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: largeSize, bottom: mediumSize),
                    child: Text(
                      widget.moment.caption,
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
