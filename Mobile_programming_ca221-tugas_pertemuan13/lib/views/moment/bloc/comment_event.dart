import '../../../models/comment.dart';

abstract class CommentEvent {}

class FetchCommentsEvent extends CommentEvent {
  final String momentId;

  FetchCommentsEvent(this.momentId);
}

class PostCommentEvent extends CommentEvent {
  final String momentId;
  final Comment comment;

  PostCommentEvent(this.momentId, this.comment);
}

class UpdateCommentEvent extends CommentEvent {
  final Comment updatedComment;

  UpdateCommentEvent(this.updatedComment);
}

class DeleteCommentEvent extends CommentEvent {
  final String commentId;

  DeleteCommentEvent(this.commentId);
}
