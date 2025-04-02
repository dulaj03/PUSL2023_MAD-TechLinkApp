import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_link/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:tech_link/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider extends ChangeNotifier {
  User? user;

  File? profileImage;
  User? updatedUser;
  bool isLoading = false;
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  final FirebaseService _firebaseService = FirebaseService();

  Future<void> captureImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
      maxWidth: 1024,
      maxHeight: 1024,
    );

    if (photo != null) {
      profileImage = File(photo.path);
      notifyListeners();
    }
  }

  Future<void> clearImage() async {
    profileImage = null;
    notifyListeners();
  }

  Future<void> registerUser(User newUser, String password) async {
    try {
      isLoading = true;
      notifyListeners();
      final authResult = await _auth.createUserWithEmailAndPassword(
        email: newUser.email,
        password: password,
      );

      String userId = authResult.user!.uid;

      String profilePictureURL = await _firebaseService.uploadImage(
        profileImage!,
        "Users",
        userId,
      );

      user = User(
        uid: authResult.user!.uid,
        username: newUser.username,
        email: newUser.email,
        contactNumber: newUser.contactNumber,
        profilePictureURL: profilePictureURL,
        age: newUser.age,
      );

      await _firebaseService.uploadDocument("Users", user!, user!.uid);
    } catch (error) {
      print("Error registering user: $error");
      throw error;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      final userCredential = await auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final userDoc =
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(userCredential.user!.uid)
              .get();

      if (userDoc.exists) {
        user = User.fromMap(userDoc);
        notifyListeners();
      } else {
        throw Exception("User profile data not found");
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      isLoading = true;
      notifyListeners();

      await _auth.signOut();

      user = null;
      profileImage = null;

      print("User logged out successfully");
    } catch (error) {
      print("Error logging out: $error");
      throw error;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getUserData() async {
    try {
      isLoading = true;
      notifyListeners();

      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception("No user is logged in");
      }

      final userDoc = await _firebaseService.getDocumentDetails(
        "Users",
        currentUser.uid,
      );

      if (userDoc.exists) {
        user = User.fromMap(userDoc);
      } else {
        throw Exception("User profile data not found");
      }
    } catch (error) {
      print("Error fetching user data: $error");
      throw error;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUserDetails({
    String? username,
    String? contactNumber,
    File? newProfileImage,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      if (user == null) {
        throw Exception("No user is logged in");
      }

      Map<String, dynamic> updatedData = {};

      updatedData['username'] = username;
      updatedData['contactNumber'] = contactNumber;
      updatedData['email'] = user!.email;
      updatedData['age'] = user!.age;

      final currentUser = _auth.currentUser;

      if (newProfileImage != null) {
        String profilePictureURL = await _firebaseService.uploadImage(
          newProfileImage,
          "Users",
          currentUser!.uid,
        );
        updatedData['profilePictureURL'] = profilePictureURL;
        profileImage = null;
      }

      user = User(
        uid: user!.uid,
        username: updatedData['username'],
        email: updatedData['email'],
        contactNumber: updatedData['contactNumber'],
        profilePictureURL:
            newProfileImage == null
                ? user!.profilePictureURL
                : updatedData['profilePictureURL'],
        age: updatedData['age'],
      );

      await _firebaseService.updateField("Users", user!, user!.uid);

      print("User details updated successfully");
    } catch (error) {
      print("Error updating user details: $error");
      throw error;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
