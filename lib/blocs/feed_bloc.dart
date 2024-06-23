// lib/blocs/feed_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/post_model.dart';
import '../services/post_service.dart';

// Events
abstract class FeedEvent {}

class LoadFeed extends FeedEvent {}

class LikePost extends FeedEvent {
  final String postId;
  final String userId;
  LikePost(this.postId, this.userId);
}

class UnlikePost extends FeedEvent {
  final String postId;
  final String userId;
  UnlikePost(this.postId, this.userId);
}

class AddComment extends FeedEvent {
  final String postId;
  final CommentModel comment;
  AddComment(this.postId, this.comment);
}

// States
abstract class FeedState {}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  final List<PostModel> posts;
  FeedLoaded(this.posts);
}

class FeedError extends FeedState {
  final String message;
  FeedError(this.message);
}

// BLoC
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final PostService _postService;

  FeedBloc(this._postService) : super(FeedInitial()) {
    on<LoadFeed>((event, emit) async {
      emit(FeedLoading());
      try {
        await emit.forEach(
          _postService.getFeedPosts(),
          onData: (List<PostModel> posts) => FeedLoaded(posts),
        );
      } catch (e) {
        emit(FeedError(e.toString()));
      }
    });

    on<LikePost>((event, emit) async {
      await _postService.likePost(event.postId, event.userId);
    });

    on<UnlikePost>((event, emit) async {
      await _postService.unlikePost(event.postId, event.userId);
    });

    on<AddComment>((event, emit) async {
      await _postService.addComment(event.postId, event.comment);
    });
  }
}
