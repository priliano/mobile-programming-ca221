// comment_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/models/comment.dart';
import 'package:myapp/repositories/databases/comment_repository.dart';

// Define the Event
abstract class CommentEvent {}

class LoadComments extends CommentEvent {
  final String momentId;

  LoadComments(this.momentId);
}

class AddComment extends CommentEvent {
  final Comment newComment;

  AddComment(this.newComment);
}

// Define the State
abstract class CommentState {}

class CommentLoading extends CommentState {}

class CommentLoaded extends CommentState {
  final List<Comment> comments;

  CommentLoaded(this.comments);
}

class CommentError extends CommentState {
  final String message;

  CommentError(this.message);
}

// Define the Bloc
class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository commentRepository;

  CommentBloc(this.commentRepository) : super(CommentLoading());

  @override
  Stream<CommentState> mapEventToState(CommentEvent event) async* {
    if (event is LoadComments) {
      try {
        // Load comments by momentId
        final comments = await commentRepository.getCommentsByMomentId(event.momentId);
        yield CommentLoaded(comments);
      } catch (e) {
        yield CommentError('Failed to load comments');
      }
    } else if (event is AddComment) {
      try {
        // Add new comment
        await commentRepository.addComment(event.newComment);
        final comments = await commentRepository.getCommentsByMomentId(event.newComment.momentId);
        yield CommentLoaded(comments);
      } catch (e) {
        yield CommentError('Failed to add comment');
      }
    }
  }
}