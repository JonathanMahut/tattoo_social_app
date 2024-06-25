import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tattoo_social_app/models/coment_model.dart';
import 'package:tattoo_social_app/models/enums/user_type.dart';
import 'package:tattoo_social_app/models/post_model.dart';
import 'package:tattoo_social_app/models/user_model.dart';
import 'package:tattoo_social_app/utils/firebase.dart'; // Assuming your FirebaseUtil class

class PostService {
  final FirebaseUtil _firebaseUtil;

  PostService(this._firebaseUtil); // Inject FirebaseUtil in constructor

  final int _postsPerPage = 10;

  Future<void> createPost({
    required UserModel user, // Add required annotation
    required String content, // Add required annotation
    String? imageUrl,
  }) async {
    // Validate user type before proceeding
    if (user.userType == UserType.client) {
      throw Exception("Clients are not allowed to create posts");
    }

    final postRef = await _firebaseUtil.firestore.collection('posts').add({
      'userId': user.id,
      'content': content,
      'mediaUrls':
          imageUrl != null ? [imageUrl] : [], // Handle optional image URL
      'mediaTypes': imageUrl != null
          ? ['image']
          : [], // Update with media types if applicable
      'createdAt': FieldValue.serverTimestamp(),
      'likes': [],
      'comments': [],
    });

    try {
      final batch = _firebaseUtil.firestore.batch();
      batch.update(
        _firebaseUtil.firestore.collection('users').doc(user.id),
        {
          'postIds': FieldValue.arrayUnion([postRef.id])
        },
      );
      await batch.commit();
      print('User postIds updated successfully');
    } catch (error) {
      print('Error updating user postIds: $error');
      // Handle potential errors (optional)
    }
    // Upload image to Firebase Storage (if applicable)
    if (imageUrl != null) {
      try {
        await _uploadImage(
            imageUrl, postRef.id); // Assuming you have an _uploadImage method
      } catch (error) {
        print('Error uploading image: $error');
        // Handle potential upload errors (optional)
      }
    }
  }

  Future<void> deletePost(String postId, String userId) async {
    // Use a batch write for efficiency (consider error handling)
    final batch = _firebaseUtil.firestore.batch();
    batch.delete(_firebaseUtil.firestore.collection('posts').doc(postId));
    batch.update(_firebaseUtil.firestore.collection('users').doc(userId), {
      'postIds': FieldValue.arrayRemove([postId])
    });
    await batch.commit();

    // Delete image from Firebase Storage (if applicable)
    await _deleteImage(postId);
  }

  Stream<List<PostModel>> getFeedPosts({DocumentSnapshot? startAfterDocument}) {
    Query query = _firebaseUtil.firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .limit(_postsPerPage);

    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => PostModel.fromFirestore(doc)).toList();
    });
  }

  Future<void> likePost(String postId, String userId) async {
    await _firebaseUtil.updateDocumentField(
      collectionPath: 'posts',
      docId: postId,
      fieldName: 'likes',
      updateValue: FieldValue.arrayUnion([userId]),
    );
  }

  Future<void> unlikePost(String postId, String userId) async {
    await _firebaseUtil.updateDocumentField(
      collectionPath: 'posts',
      docId: postId,
      fieldName: 'likes',
      updateValue: FieldValue.arrayRemove([userId]),
    );
  }

  Future<void> addComment(String postId, CommentModel comment) async {
    await _firebaseUtil.updateDocumentField(
      collectionPath: 'posts',
      docId: postId,
      fieldName: 'comments',
      updateValue: FieldValue.arrayUnion([comment.toMap()]),
    );
  }

  Future<void> _uploadImage(String imageUrl, String postId) async {
    try {
      // Get a reference to the image storage location (modify path if needed)
      final imageRef = _firebaseUtil.storage.ref().child('posts/$postId');

      // Create a task to upload the image
      final uploadTask = await imageRef
          .putFile(File(imageUrl)); // Assuming imageUrl points to a local file

      // Get the download URL for the uploaded image
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      // Update the post document with the download URL (optional)
      await _firebaseUtil.updateDocumentField(
        collectionPath: 'posts',
        docId: postId,
        fieldName: 'mediaUrls',
        updateValue: FieldValue.arrayUnion([downloadUrl]),
      );

      print('Image uploaded successfully: $downloadUrl');
    } catch (error) {
      print('Error uploading image: $error');
      // Handle potential upload errors (optional)
    }
  }

  Future<void> _deleteImage(String postId) async {
    try {
      // Get a reference to the image in Storage based on your storage structure
      final imageRef = _firebaseUtil.storage
          .ref()
          .child('posts/$postId'); // Modify path if needed

      // Attempt to delete the image
      await imageRef.delete();
      print('Image deleted successfully from Storage');
    } catch (error) {
      print('Error deleting image: $error');
      // Handle potential errors during deletion (optional)
    }
  }

  // Fonction pour compter le nombre de likes reçus par un post
  Future<int> getPostLikesCount(String postId) async {
    try {
      final DocumentSnapshot postDoc =
          await _firebaseUtil.firestore.collection('posts').doc(postId).get();

      if (postDoc.exists) {
        final data = postDoc.data() as Map<String, dynamic>;
        final likes = data['likes'] as List<dynamic>?;
        return likes?.length ?? 0;
      } else {
        print('Post non trouvé');
        return 0;
      }
    } catch (error) {
      print('Erreur lors du comptage des likes: $error');
      return 0;
    }
  }

  // Fonction pour compter le nombre de commentaires qu'un post a reçu
  Future<int> getPostCommentsCount(String postId) async {
    try {
      final DocumentSnapshot postDoc =
          await _firebaseUtil.firestore.collection('posts').doc(postId).get();

      if (postDoc.exists) {
        final data = postDoc.data() as Map<String, dynamic>;
        final comments = data['comments'] as List<dynamic>?;
        return comments?.length ?? 0;
      } else {
        print('Post non trouvé');
        return 0;
      }
    } catch (error) {
      print('Erreur lors du comptage des commentaires: $error');
      return 0;
    }
  }
}
