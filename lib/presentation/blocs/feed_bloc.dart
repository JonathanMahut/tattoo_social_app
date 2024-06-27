// lib/blocs/feed_bloc.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tattoo_social_app/data/models/coment_model.dart';

import '../../data/models/post_model.dart';
import '../../services/post_service.dart';

// Events
abstract class FeedEvent {}

class LoadFeed extends FeedEvent {}

// Ajoutez ces événements
class LoadMoreFeed extends FeedEvent {}

class FeedLoaded extends FeedState {
  final List<PostModel> posts;
  final bool hasReachedMax;
  final DocumentSnapshot? lastDocument;

  FeedLoaded(this.posts, {this.hasReachedMax = false, this.lastDocument});
}

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

// class FeedLoaded extends FeedState {
//   final List<PostModel> posts;
//   FeedLoaded(this.posts);
// }

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
      await _loadPosts(emit);
    });

    // FeedBloc(this._postService) : super(FeedInitial()) {
    //   on<LoadFeed>((event, emit) async {
    //     emit(FeedLoading());
    //     try {
    //       await emit.forEach(
    //         _postService.getFeedPosts(),
    //         onData: (List<PostModel> posts) => FeedLoaded(posts),
    //       );
    //     } catch (e) {
    //       emit(FeedError(e.toString()));
    //     }
    //   });

    on<LoadMoreFeed>((event, emit) async {
      if (state is FeedLoaded) {
        final currentState = state as FeedLoaded;
        if (!currentState.hasReachedMax) {
          await _loadPosts(emit, startAfter: currentState.lastDocument);
        }
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

  Future<void> _loadPosts(Emitter<FeedState> emit,
      {DocumentSnapshot? startAfter}) async {
    try {
      final posts =
          await _postService.getFeedPosts(startAfterDocument: startAfter).first;
      if (state is FeedLoaded) {
        final currentState = state as FeedLoaded;
        emit(FeedLoaded(
          [...currentState.posts, ...posts],
          hasReachedMax: posts.isEmpty,
          lastDocument: posts.isNotEmpty
              ? await posts.last.reference.get() // Obtenez le DocumentSnapshot
              : currentState.lastDocument,
        ));
      } else {
        emit(FeedLoaded(
          posts,
          hasReachedMax: posts.isEmpty,
          lastDocument: posts.isNotEmpty
              ? await posts.last.reference.get() // Obtenez le DocumentSnapshot
              : null,
        ));
      }
    } catch (e) {
      emit(FeedError(e.toString()));
    }
  }
}
