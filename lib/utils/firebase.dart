import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FirebaseUtil {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  final Uuid uuid;

  // Collection references (moved outside constructor for better access)
  final CollectionReference usersRef;
  final CollectionReference postRef;
  final CollectionReference commentRef;
  final CollectionReference followersRef;
  final CollectionReference followingRef;
  final CollectionReference likesRef;

  // Storage references (moved outside constructor for better access)
  final Reference profilePicRef;
  final Reference tattoosRef;
  final Reference postsRef;

  FirebaseUtil({
    required this.auth,
    required this.firestore,
    required this.storage,
    required this.uuid,
  })  : usersRef = firestore.collection('users'),
        postRef = firestore.collection('posts'),
        commentRef = firestore.collection('comments'),
        followersRef = firestore.collection('followers'),
        followingRef = firestore.collection('following'),
        likesRef = firestore.collection('likes'),
        profilePicRef = storage.ref().child('profilePic'),
        tattoosRef = storage.ref().child('tattoos'),
        postsRef = storage.ref().child('posts');

  // Methods for interacting with Firebase can be added here (optional)
  Future<void> updateDocumentField({
    required String collectionPath,
    required String docId,
    required String fieldName,
    required dynamic updateValue,
  }) async {
    await firestore.collection(collectionPath).doc(docId).update({
      fieldName: updateValue,
    });
  }
}
