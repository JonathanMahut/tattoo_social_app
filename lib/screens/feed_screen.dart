// lib/screens/feed_screen.dart

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tattoo_social_app/providers/user_provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../blocs/feed_bloc.dart';
import '../models/post_model.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(
      builder: (context, state) {
        if (state is FeedInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FeedLoaded) {
          return ListView.builder(
            itemCount: state.posts.length + 1,
            itemBuilder: (context, index) {
              if (index >= state.posts.length) {
                return state.hasReachedMax
                    ? Container()
                    : const Center(child: CircularProgressIndicator());
              }
              return PostWidget(post: state.posts[index]);
            },
            controller: _scrollController,
          );
        } else if (state is FeedError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return const Center(child: Text('No posts available'));
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      context.read<FeedBloc>().add(LoadMoreFeed());
    }
  }
}

class PostWidget extends StatelessWidget {
  final PostModel post;

  const PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          _buildMediaCarousel(),
          _buildContent(),
          _buildDateAndLikes(context),
          _buildCommentSection(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to user profile
        // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(userId: post.userId)));
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black54, Colors.transparent],
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(post.user.profileImageUrl ?? ''),
              radius: 20,
            ),
            const SizedBox(width: 8),
            Text(
              post.user.username,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 1,
        viewportFraction: 1,
        enableInfiniteScroll: false,
      ),
      items: post.mediaUrls.map((url) {
        return Builder(
          builder: (BuildContext context) {
            if (post.mediaTypes[post.mediaUrls.indexOf(url)] == 'image') {
              return Image.network(url, fit: BoxFit.cover);
            } else {
              // Implement video player here
              return Container(child: const Text('Video Player'));
            }
          },
        );
      }).toList(),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(post.content),
    );
  }

  Widget _buildDateAndLikes(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final currentUserId = userProvider.currentUser?.id;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            timeago.format(post.createdAt),
            style: const TextStyle(color: Colors.grey),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  post.likes.contains(currentUserId)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: post.likes.contains(currentUserId) ? Colors.red : null,
                ),
                onPressed: () {
                  if (currentUserId != null) {
                    if (post.likes.contains(currentUserId)) {
                      context
                          .read<FeedBloc>()
                          .add(UnlikePost(post.id, currentUserId));
                    } else {
                      context
                          .read<FeedBloc>()
                          .add(LikePost(post.id, currentUserId));
                    }
                  }
                },
              ),
              Text('${post.likes.length}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommentSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Comments (${post.comments.length})'),
          TextField(
            decoration: InputDecoration(
              hintText: 'Add a comment...',
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  // Add comment logic
                  // context.read<FeedBloc>().add(AddComment(post.id, newComment));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
