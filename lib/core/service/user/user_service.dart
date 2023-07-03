import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:runner_plan_app/core/exception/custom_firebase_exception.dart';
import 'package:runner_plan_app/core/interface/user/user_interface.dart';
import 'package:runner_plan_app/core/model/common/session_user_model.dart';

class UserService implements UserInterface {
  @override
  Future<void> savePersonalUser(SessionUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection('users').doc(user.id);

    await docRef.set({
      'name': user.name,
      'email': user.email,
      'imageURL': user.imageURL,
      'roles': {'personal': true}
    });

    await docRef.collection('personal').add({'cref': user.personal?.cref});
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

      return responseUrl;
    } on FirebaseException catch (error) {
      throw CustomFirebaseException(error.code);
    }
  }
}
