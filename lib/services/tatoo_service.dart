import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tattoo_social_app/core/utils/firebase.dart'; // Assuming your FirebaseUtil class
import 'package:tattoo_social_app/data/models/coment_model.dart';
import 'package:tattoo_social_app/data/models/tattoo_model.dart';

class TattooService {
  final FirebaseUtil _firebaseUtil;

  TattooService(this._firebaseUtil);

  final int _tattoosPerPage = 10;

  Future<void> createTattoo(TattooModel tattoo) async {
    // Add the tattoo document to Firestore
    final tattooRef = await _firebaseUtil.firestore
        .collection('tattoos')
        .add(tattoo.toFirestore());

    // Update the user's tattoo IDs (if applicable)
    try {
      final batch = _firebaseUtil.firestore.batch();
      batch.update(
        _firebaseUtil.firestore.collection('users').doc(tattoo.userId),
        {
          'tattooIds': FieldValue.arrayUnion([tattooRef.id]),
        },
      );
      await batch.commit();
      print('User tattooIds updated successfully');
    } catch (error) {
      print('Error updating user tattooIds: $error');
      // Handle potential errors (optional)
    }

    // Upload image to Firebase Storage (if applicable)
    if (tattoo.imageUrl.isNotEmpty) {
      try {
        await _uploadImage(tattoo.imageUrl, tattooRef.id);
      } catch (error) {
        print('Error uploading image: $error');
        // Handle potential upload errors (optional)
      }
    }
  }

  Future<void> deleteTattoo(String tattooId, String userId) async {
    // Use a batch write for efficiency (consider error handling)
    final batch = _firebaseUtil.firestore.batch();
    batch.delete(_firebaseUtil.firestore.collection('tattoos').doc(tattooId));
    batch.update(_firebaseUtil.firestore.collection('users').doc(userId), {
      'tattooIds': FieldValue.arrayRemove([tattooId]),
    });
    await batch.commit();

    // Delete image from Firebase Storage (if applicable)
    await _deleteImage(tattooId);
  }

  Stream<List<TattooModel>> getFeedTattoos(
      {DocumentSnapshot? startAfterDocument}) {
    Query query = _firebaseUtil.firestore
        .collection('tattoos')
        .orderBy('createdAt', descending: true)
        .limit(_tattoosPerPage);

    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => TattooModel.fromFirestore(doc))
          .toList();
    });
  }

  Future<void> reserveTattoo(String tattooId, String userId) async {
    await _firebaseUtil.updateDocumentField(
      collectionPath: 'tattoos',
      docId: tattooId,
      fieldName: 'isReserved',
      updateValue: true,
    );
  }

  Future<void> unreserveTattoo(String tattooId, String userId) async {
    await _firebaseUtil.updateDocumentField(
      collectionPath: 'tattoos',
      docId: tattooId,
      fieldName: 'isReserved',
      updateValue: false,
    );
  }

  Future<void> likeTattoo(String tattooId, String userId) async {
    await _firebaseUtil.updateDocumentField(
      collectionPath: 'tattoos',
      docId: tattooId,
      fieldName: 'likes',
      updateValue: FieldValue.arrayUnion([userId]),
    );
  }

  Future<void> unlikeTattoo(String tattooId, String userId) async {
    await _firebaseUtil.updateDocumentField(
      collectionPath: 'tattoos',
      docId: tattooId,
      fieldName: 'likes',
      updateValue: FieldValue.arrayRemove([userId]),
    );
  }

  Future<void> addComment(String tattooId, CommentModel comment) async {
    await _firebaseUtil.updateDocumentField(
      collectionPath: 'tattoos',
      docId: tattooId,
      fieldName: 'comments',
      updateValue: FieldValue.arrayUnion([comment.toMap()]),
    );
  }

  Future<void> _uploadImage(String imageUrl, String tattooId) async {
    try {
      // Get a reference to the image storage location (modify path if needed)
      final imageRef = _firebaseUtil.storage.ref().child('tattoos/$tattooId');

      // Create a task to upload the image
      final uploadTask = await imageRef
          .putFile(File(imageUrl)); // Assuming imageUrl points to a local file

      // Get the download URL for the uploaded image
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      // Update the tattoo document with the download URL (optional)
      await _firebaseUtil.updateDocumentField(
        collectionPath: 'tattoos',
        docId: tattooId,
        fieldName: 'imageUrl',
        updateValue: downloadUrl,
      );

      print('Image uploaded successfully: $downloadUrl');
    } catch (error) {
      print('Error uploading image: $error');
      // Handle potential upload errors (optional)
    }
  }

  Future<void> _deleteImage(String tattooId) async {
    try {
      // Get a reference to the image in Storage based on your storage structure
      final imageRef = _firebaseUtil.storage.ref().child('tattoos/$tattooId');

      // Attempt to delete the image
      await imageRef.delete();
      print('Image deleted successfully from Storage');
    } catch (error) {
      print('Error deleting image: $error');
      // Handle potential errors during deletion (optional)
    }
  }

  // Fonction pour compter le nombre de likes reçus par un tatouage
  Future<int> getTattooLikesCount(String tattooId) async {
    try {
      final DocumentSnapshot tattooDoc = await _firebaseUtil.firestore
          .collection('tattoos')
          .doc(tattooId)
          .get();

      if (tattooDoc.exists) {
        final data = tattooDoc.data() as Map<String, dynamic>;
        final likes = data['likes'] as List<dynamic>?;
        return likes?.length ?? 0;
      } else {
        print('Tattoo non trouvé');
        return 0;
      }
    } catch (error) {
      print('Erreur lors du comptage des likes: $error');
      return 0;
    }
  }

  // Fonction pour compter le nombre de commentaires qu'un tatouage a reçu
  Future<int> getTattooCommentsCount(String tattooId) async {
    try {
      final DocumentSnapshot tattooDoc = await _firebaseUtil.firestore
          .collection('tattoos')
          .doc(tattooId)
          .get();

      if (tattooDoc.exists) {
        final data = tattooDoc.data() as Map<String, dynamic>;
        final comments = data['comments'] as List<dynamic>?;
        return comments?.length ?? 0;
      } else {
        print('Tattoo non trouvé');
        return 0;
      }
    } catch (error) {
      print('Erreur lors du comptage des commentaires: $error');
      return 0;
    }
  }
}
