import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tattoo_social_app/models/coment_model.dart';

class TattooModel {
  final String id;
  final String userId;
  final String imageUrl;
  final String style;
  final String description;
  final List<CommentModel> comments;
  final bool isReserved;
  final bool isAvailable;
  final List<String> likes;

  TattooModel({
    required this.id,
    required this.userId,
    required this.imageUrl,
    required this.style,
    required this.description,
    required this.comments,
    required this.isReserved,
    required this.isAvailable,
    required this.likes,
  });

  factory TattooModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return TattooModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      style: data['style'] ?? '',
      description: data['description'] ?? '',
      comments: (data['comments'] as List<dynamic>? ?? [])
          .map((comment) => CommentModel.fromMap(comment))
          .toList(),
      isReserved: data['isReserved'] ?? false,
      isAvailable: data['isAvailable'] ?? true,
      likes: List<String>.from(data['likes'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'imageUrl': imageUrl,
      'style': style,
      'description': description,
      'comments': comments.map((comment) => comment.toMap()).toList(),
      'isReserved': isReserved,
      'isAvailable': isAvailable,
      'likes': likes,
    };
  }
}
