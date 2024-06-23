// lib/services/post_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/post_model.dart';
import '../models/user_model.dart';

class PostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createPost(
      UserModel user, String content, String? imageUrl) async {
    if (user.userType == UserType.client) {
      throw Exception("Clients are not allowed to create posts");
    }

    DocumentReference postRef = await _firestore.collection('posts').add({
      'userId': user.id,
      'content': content,
      'imageUrl': imageUrl,
      'createdAt': FieldValue.serverTimestamp(),
      'likes': [],
      'comments': [],
    });

    await _firestore.collection('users').doc(user.id).update({
      'postIds': FieldValue.arrayUnion([postRef.id])
    });
  }

  Stream<List<PostModel>> getFeedPosts() {
    return _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => PostModel.fromFirestore(doc)).toList());
  }

  Future<void> likePost(String postId, String userId) async {
    await _firestore.collection('posts').doc(postId).update({
      'likes': FieldValue.arrayUnion([userId])
    });
  }

  Future<void> unlikePost(String postId, String userId) async {
    await _firestore.collection('posts').doc(postId).update({
      'likes': FieldValue.arrayRemove([userId])
    });
  }

  Future<void> addComment(String postId, CommentModel comment) async {
    await _firestore.collection('posts').doc(postId).update({
      'comments': FieldValue.arrayUnion([comment.toMap()])
    });
  }
}
