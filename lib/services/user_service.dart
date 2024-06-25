import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tattoo_social_app/models/enums/user_type.dart';
import 'package:tattoo_social_app/models/user_model.dart';
import 'package:tattoo_social_app/utils/firebase.dart';

class UserService {
  final FirebaseUtil firebaseUtil;

  UserService(this.firebaseUtil);

  // Fetch a user by ID
  Future<UserModel?> getUser(String userId) async {
    final docSnapshot = await firebaseUtil.usersRef.doc(userId).get();
    return docSnapshot.exists ? UserModel.fromFirestore(docSnapshot) : null;
  }

  // Fetch current user data (if logged in)
  Future<UserModel?> getCurrentUser() async {
    final uid = firebaseUtil.auth.currentUser?.uid;
    if (uid == null) return null;
    return await getUser(uid); // Use the getUser method with current UID
  }

  // Add a new user
  Future<void> addUser(UserModel user) async {
    try {
      await firebaseUtil.usersRef.doc(user.id).set(user.toMap());
    } catch (e) {
      print('Error adding user: $e');
      // You might want to rethrow the error or handle it in a specific way
      throw Exception('Failed to add user');
    }
  }

  // Update user data
  Future<void> updateUser(UserModel user) async {
    await firebaseUtil.usersRef.doc(user.id).update(user.toMap());
  }

  // Follow a user
  Future<void> followUser(String userIdToFollow) async {
    final currentUserId = firebaseUtil.auth.currentUser?.uid;
    if (currentUserId == null) {
      throw Exception('No current user found');
    }

    await firebaseUtil.firestore.runTransaction((transaction) async {
      transaction.set(
        firebaseUtil.followingRef
            .doc(currentUserId)
            .collection('following')
            .doc(userIdToFollow),
        {},
      );
      transaction.set(
        firebaseUtil.followersRef
            .doc(userIdToFollow)
            .collection('followers')
            .doc(currentUserId),
        {},
      );
    });
  }

  // Unfollow a user
  Future<void> unfollowUser(String userIdToUnfollow) async {
    final currentUserId = firebaseUtil.auth.currentUser?.uid;
    if (currentUserId == null) return;
    await firebaseUtil.followingRef
        .doc(currentUserId)
        .collection('following')
        .doc(userIdToUnfollow)
        .delete();
    await firebaseUtil.followersRef
        .doc(userIdToUnfollow)
        .collection('followers')
        .doc(currentUserId)
        .delete();
  }

  // Upload profile picture
  Future<String> uploadProfilePicture(String filePath) async {
    final ref =
        firebaseUtil.profilePicRef.child(firebaseUtil.auth.currentUser!.uid);
    final uploadTask = await ref.putFile(File(filePath));
    final downloadUrl = await uploadTask.ref.getDownloadURL();
    return downloadUrl;
  }

  // Upload a new post
  Future<void> uploadPost(UserModel user, String content) async {
    if (user.userType != UserType.tattooArtist &&
        user.userType != UserType.eventOrganizer &&
        user.userType != UserType.supplier) {
      throw Exception('Clients cannot upload posts');
    }

    final docRef = firebaseUtil.postRef.doc();
    await docRef.set({
      'id': docRef.id,
      'userId': user.id,
      'content': content,
      'createdAt': DateTime.now(),
      // Add other relevant post data fields here
    });
  }

  Future<void> updateUserField(
      String userId, String field, dynamic value) async {
    await firebaseUtil.usersRef.doc(userId).update({field: value});
  }

  Future<List<UserModel>> getUsers(
      {int limit = 10, DocumentSnapshot? startAfter}) {
    Query query = firebaseUtil.usersRef.orderBy('username').limit(limit);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    return query.get().then((snapshot) {
      return snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
    });
  }

  // Check if a user follows another user
  Future<bool> isFollowing(String userId, String otherUserId) async {
    final doc = await firebaseUtil.followingRef
        .doc(userId)
        .collection('following')
        .doc(otherUserId)
        .get();
    return doc.exists;
  }

  // Compter le nombre de Followers d'un User
  Future<int> getFollowersCount(String userId) async {
    try {
      final QuerySnapshot snapshot = await firebaseUtil.followersRef
          .doc(userId)
          .collection('followers')
          .get();
      return snapshot.docs.length;
    } catch (e) {
      print('Erreur lors du comptage des followers: $e');
      return 0;
    }
  }

  // Compter combien de User un User Follow
  Future<int> getFollowingCount(String userId) async {
    try {
      final QuerySnapshot snapshot = await firebaseUtil.followingRef
          .doc(userId)
          .collection('following')
          .get();
      return snapshot.docs.length;
    } catch (e) {
      print('Erreur lors du comptage des following: $e');
      return 0;
    }
  }

  // Compter Combien de Post ont été créé par un User
  Future<int> getUserPostsCount(String userId) async {
    try {
      final QuerySnapshot snapshot =
          await firebaseUtil.postRef.where('userId', isEqualTo: userId).get();
      return snapshot.docs.length;
    } catch (e) {
      print('Erreur lors du comptage des posts: $e');
      return 0;
    }
  }

  // Compter Combien de Post ont été likés par un User
  Future<int> getUserLikedPostsCount(String userId) async {
    try {
      final QuerySnapshot snapshot = await firebaseUtil.postRef
          .where('likes', arrayContains: userId)
          .get();
      return snapshot.docs.length;
    } catch (e) {
      print('Erreur lors du comptage des posts likés: $e');
      return 0;
    }
  }
}
