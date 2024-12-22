import 'package:flutter_bloc/flutter_bloc.dart';
import 'comment_event.dart';
import 'comment_state.dart';
import 'package:myapp/repositories/contracts/abs_api_comment_repository.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final AbsApiCommentRepository commentRepository;

  CommentBloc({required this.commentRepository}) : super(CommentInitial()) {
    on<FetchCommentsEvent>(_onFetchComments);
    on<PostCommentEvent>(_onPostComment);
    on<UpdateCommentEvent>(_onUpdateComment);
    on<DeleteCommentEvent>(_onDeleteComment);
  }

  Future<void> _onFetchComments(FetchCommentsEvent event, Emitter<CommentState> emit) async {
    emit(CommentLoading());
    try {
      final comments = await commentRepository.getAll(event.momentId);
      emit(CommentLoaded(comments));
    } catch (e) {
      emit(CommentError('Failed to fetch comments: $e'));
    }
  }

  Future<void> _onPostComment(PostCommentEvent event, Emitter<CommentState> emit) async {
    try {
      await commentRepository.create(event.comment);
      emit(CommentSuccess('Comment posted successfully!'));
      add(FetchCommentsEvent(event.momentId)); // Refresh comments after posting
    } catch (e) {
      emit(CommentError('Failed to post comment: $e'));
    }
  }

  Future<void> _onUpdateComment(UpdateCommentEvent event, Emitter<CommentState> emit) async {
    try {
      final success = await commentRepository.update(event.updatedComment);
      if (success) {
        emit(CommentSuccess('Comment updated successfully!'));
        add(FetchCommentsEvent(event.updatedComment.momentId)); // Refresh comments
      } else {
        emit(CommentError('Failed to update comment.'));
      }
    } catch (e) {
      emit(CommentError('Failed to update comment: $e'));
    }
  }

  Future<void> _onDeleteComment(DeleteCommentEvent event, Emitter<CommentState> emit) async {
    try {
      final success = await commentRepository.delete(event.commentId);
      if (success) {
        emit(CommentSuccess('Comment deleted successfully!'));
      } else {
        emit(CommentError('Failed to delete comment.'));
      }
    } catch (e) {
      emit(CommentError('Failed to delete comment: $e'));
    }
  }
}
