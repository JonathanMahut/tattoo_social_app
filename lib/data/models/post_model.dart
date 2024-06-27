// lib/models/post_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tattoo_social_app/data/models/coment_model.dart';
import 'package:tattoo_social_app/data/models/user_model.dart';

class PostModel {
  final String id;
  final String userId;
  final String content;
  //final String? imageUrl;
  final List<String> mediaUrls; // Replace 'imageUrl' with 'mediaUrls'
  final List<String> mediaTypes; // Add a list for media types
  final DateTime createdAt;
  final List<String> likes;
  final List<CommentModel> comments;

  final UserModel user;

  final DocumentReference reference; // Ajoutez cette ligne

  PostModel({
    required this.id,
    required this.userId,
    required this.content,
    this.mediaUrls = const [], // Initialize with empty lists
    this.mediaTypes = const [], // Initialize with empty lists
    required this.createdAt,
    required this.likes,
    required this.comments,
    required this.user,
    required this.reference, // Ajoutez cette ligne
  });

  factory PostModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return PostModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      content: data['content'] ?? '',
      mediaUrls: List<String>.from(data['mediaUrls'] ?? []),
      mediaTypes: List<String>.from(data['mediaTypes'] ?? []),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      likes: List<String>.from(data['likes'] ?? []),
      comments: (data['comments'] as List<dynamic>? ?? [])
          .map((comment) => CommentModel.fromMap(comment))
          .toList(),
      user: UserModel.fromMap(
          data['user'] ?? {}, data['user']), // Parse user data
      reference: doc.reference, // Ajoutez cette ligne
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'content': content,
      'mediaUrls': mediaUrls, // No need to convert as it's already a list
      'mediaTypes': mediaTypes, // No need to convert as it's already a list
      'createdAt': Timestamp.fromDate(createdAt),
      'likes': likes,
      'comments': comments.map((comment) => comment.toMap()).toList(),
      'user': user.toMap(), // Convert UserModel to Map'
    };
  }
}
