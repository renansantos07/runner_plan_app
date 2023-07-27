import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:runner_plan_app/core/exception/custom_firebase_exception.dart';
import 'package:runner_plan_app/core/interface/user/user_interface.dart';
import 'package:runner_plan_app/core/model/common/session_user_model.dart';

class UserService implements UserInterface {
  final _collection = 'users';

  @override
  Future<void> savePersonalUser(SessionUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection(_collection).doc(user.id);

    try {
      await docRef.set({
        'name': user.name,
        'surname': user.surname,
        'email': user.email,
        'imageURL': user.imageURL,
        'roles': {
          'personal': true,
          'athlete': false,
        },
        'cref': user.cref
      });
    } on FirebaseException catch (error) {
      throw CustomFirebaseException(error.code);
    }
  }

  @override
  Future<void> saveAthleteUser(SessionUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection(_collection).doc(user.id);

    try {
      await docRef.set({
        'name': user.name,
        'surname': user.surname,
        'email': user.email,
        'imageURL': user.imageURL,
        'roles': {
          'personal': false,
          'athlete': true,
        },
      });
    } on FirebaseException catch (error) {
      throw CustomFirebaseException(error.code);
    }
  }

  Future<void> _updateUserImageUrl(String userId, String imageUrl) async {
    final userRef =
        FirebaseFirestore.instance.collection(_collection).doc(userId);

    await userRef.update({
      'imageURL': imageUrl,
    });
  }

  Future<SessionUser> updateUser(SessionUser user) async {
    try {
      final userRef = FirebaseFirestore.instance
          .collection(_collection)
          .withConverter(
              fromFirestore: _firestoreToSessionUser,
              toFirestore: _sessionUserToFirestore)
          .doc(user.id);

      await userRef.update({
        'name': user.name,
        'surname': user.surname,
        'email': user.email,
      });

      final sessionUser = await userRef.get();

      return sessionUser.data()!;
    } on FirebaseException catch (error) {
      throw CustomFirebaseException(error.code);
    }
  }

  Future<SessionUser> getUser(String userId) async {
    final userRef = await FirebaseFirestore.instance
        .collection(_collection)
        .withConverter(
            fromFirestore: _firestoreToSessionUser,
            toFirestore: _sessionUserToFirestore)
        .doc(userId);

    final sessionUser = await userRef.get();

    return sessionUser.data()!;
  }

  @override
  Future<String?> uploadUserImage(File? image) async {
    if (image == null) return null;

    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) return '';

      final imageName = '${user.uid}.jpg';

      final storage = FirebaseStorage.instance;
      final imageRef = storage.ref().child('user_images').child(imageName);

      await imageRef.putFile(image).whenComplete(() {});
      final responseUrl = await imageRef.getDownloadURL();

      await user.updatePhotoURL(responseUrl);
      await _updateUserImageUrl(user.uid, responseUrl);

      return responseUrl;
    } on FirebaseException catch (error) {
      throw CustomFirebaseException(error.code);
    }
  }

  // SessionUser => Map<String, dynamic>
  Map<String, dynamic> _sessionUserToFirestore(
    SessionUser sessionUser,
    SetOptions? options,
  ) {
    return {
      'name': sessionUser.name,
      'surname': sessionUser.surname,
      'email': sessionUser.email,
      'imageURL': sessionUser.imageURL,
    };
  }

  // Map<String, dynamic> => SessionUser
  SessionUser _firestoreToSessionUser(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    return SessionUser(
      id: doc.id,
      name: doc['name'],
      surname: doc['surname'],
      email: doc['email'],
      imageURL: doc['imageURL'],
    );
  }
}
