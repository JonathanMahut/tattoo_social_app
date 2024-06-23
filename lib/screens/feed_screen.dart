// lib/screens/feed_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/feed_bloc.dart';
import '../models/post_model.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(
      builder: (context, state) {
        if (state is FeedLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is FeedLoaded) {
          return ListView.builder(
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              return PostWidget(post: state.posts[index]);
            },
          );
        } else if (state is FeedError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return Center(child: Text('No posts available'));
      },
    );
  }
}

class PostWidget extends StatelessWidget {
  final PostModel post;

  PostWidget({required this.post});

  @override
  Widget build(BuildContext context) {
    // Implement the UI for a single post
    // Include like button, comment section, etc.
    return Card(
        // ... implement post UI
        );
  }
}
