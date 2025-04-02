import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:tech_link/model/user.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<DocumentSnapshot> getDocumentDetails(
    String collection,
    String document,
  ) async {
    try {
      return await _db.collection(collection).doc(document).get();
    } catch (e) {
      throw Exception('Failed to fetch document: $e');
    }
  }

  Future<QuerySnapshot> getDocuments(String collection) async {
    try {
      return await _db.collection(collection).get();
    } catch (e) {
      throw Exception('Failed to fetch documents: $e');
    }
  }

  Future<QuerySnapshot> getDocumentsWithField({
    required String collection,
    required String fieldName,
    required dynamic fieldValue,
  }) async {
    try {
      return await _db
          .collection(collection)
          .where(fieldName, isEqualTo: fieldValue)
          .get();
    } catch (e) {
      throw Exception('Failed to fetch documents with field $fieldName: $e');
    }
  }

  Future<String> uploadImage(
    File file,
    String basePath,
    String folderId,
  ) async {
    try {
      final storagePath = '$basePath/$folderId/images';

      final fileExtension = file.path.split('.').last;
      final fileName =
          '$folderId-${DateTime.now().millisecondsSinceEpoch}.$fileExtension';

      final ref = _storage.ref().child('$storagePath/$fileName');
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        cacheControl: 'max-age=3600',
      );

      final uploadTask = ref.putFile(file, metadata);
      final snapshot = await uploadTask.whenComplete(() {});

      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload file: $e');
    }
  }

  Future<String> uploadAudioFile(
    String audioPath,
    String basePath,
    String patientFolderId,
  ) async {
    try {
      final audioFile = File(audioPath);
      final fileName = audioPath.split('/').last;
      final storagePath = '$basePath/$patientFolderId/audio/$fileName';
      final ref = _storage.ref().child(storagePath);

      final metadata = SettableMetadata(
        contentType: 'audio/mpeg',
        cacheControl: 'max-age=3600',
      );

      final uploadTask = ref.putFile(audioFile, metadata);
      final snapshot = await uploadTask.whenComplete(() {});

      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload audio file: $e');
    }
  }

  Future<DocumentReference> uploadDocument(
    String collection,
    User userData,
    String documentId,
  ) async {
    try {
      final docRef = _db.collection(collection).doc(documentId);
      await docRef.set(userData.toMap());
      return docRef;
    } catch (e) {
      throw Exception('Failed to upload document: $e');
    }
  }

  Future<DocumentReference> updateField(
    String collection,
    User userData,
    String documentId,
  ) async {
    try {
      final docRef = _db.collection(collection).doc(documentId);
      await docRef.update(userData.toMap());
      return docRef;
    } catch (e) {
      throw Exception('Failed to upload document: $e');
    }
  }
}
