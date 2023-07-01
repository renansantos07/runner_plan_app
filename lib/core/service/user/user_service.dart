import 'package:cloud_firestore/cloud_firestore.dart';
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
}
