import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:runner_plan_app/core/exception/custom_firebase_exception.dart';
import 'package:runner_plan_app/core/interface/Auth/auth_interface.dart';
import 'package:runner_plan_app/core/interface/user/user_interface.dart';
import 'package:runner_plan_app/core/model/common/session_user_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:runner_plan_app/core/model/personal/personal_modal.dart';

class AuthService implements AuthInterface {
  static SessionUser? _sessionUser;
  static final _userStream = Stream<SessionUser?>.multi(
    (controller) async {
      final authChanges = FirebaseAuth.instance.authStateChanges();
      await for (final user in authChanges) {
        _sessionUser = user == null ? null : _firebaseUserToSessionUser(user);
        controller.add(_sessionUser);
      }
    },
  );

  @override
  SessionUser? get sessionUser {
    return _sessionUser;
  }

  @override
  Stream<SessionUser?> get userChanges {
    return _userStream;
  }

  @override
  Future<void> login(String email, String password) async {
    try {
      final authInstance = FirebaseAuth.instance;
      UserCredential credential = await authInstance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseException catch (error) {
      throw CustomFirebaseException(error.code);
    }
  }

  @override
  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> signup(
      String name, String cref, String email, String password) async {
    try {
      final signup = await Firebase.initializeApp(
        name: 'userSignup',
        options: Firebase.app().options,
      );
      final authInstance = FirebaseAuth.instanceFor(app: signup);

      UserCredential credential =
          await authInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        // 2. atualizar os atributos do usuário
        await credential.user?.sendEmailVerification();
        await credential.user?.updateDisplayName(name);

        // 2.5 fazer o login do usuário
        await login(email, password);

        // 3. salvar usuário no banco de dados (opcional)
        _sessionUser = _firebaseUserToSessionUser(credential.user!, name, cref);
        await UserInterface().savePersonalUser(_sessionUser!);
      }

      await signup.delete();
    } on FirebaseException catch (error) {
      throw CustomFirebaseException(error.code);
    }
  }

  @override
  Future<void> forgetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseException catch (error) {
      throw CustomFirebaseException(error.code);
    }
  }

  @override
  Future<void> getCref(String? cref) async {
    cref = "041942-G/SP";
    String baseUrl =
        'https://www.confef.org.br/confef/registrados/ssp.registrados.php?draw=18&columns%5B0%5D%5Bdata%5D=0&columns%5B0%5D%5Bname%5D=&columns%5B0%5D%5Bsearchable%5D=true&columns%5B0%5D%5Borderable%5D=false&columns%5B0%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B0%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B1%5D%5Bdata%5D=1&columns%5B1%5D%5Bname%5D=&columns%5B1%5D%5Bsearchable%5D=true&columns%5B1%5D%5Borderable%5D=true&columns%5B1%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B1%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B2%5D%5Bdata%5D=2&columns%5B2%5D%5Bname%5D=&columns%5B2%5D%5Bsearchable%5D=true&columns%5B2%5D%5Borderable%5D=true&columns%5B2%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B2%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B3%5D%5Bdata%5D=3&columns%5B3%5D%5Bname%5D=&columns%5B3%5D%5Bsearchable%5D=true&columns%5B3%5D%5Borderable%5D=true&columns%5B3%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B3%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B4%5D%5Bdata%5D=4&columns%5B4%5D%5Bname%5D=&columns%5B4%5D%5Bsearchable%5D=true&columns%5B4%5D%5Borderable%5D=true&columns%5B4%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B4%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B5%5D%5Bdata%5D=5&columns%5B5%5D%5Bname%5D=&columns%5B5%5D%5Bsearchable%5D=true&columns%5B5%5D%5Borderable%5D=true&columns%5B5%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B5%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B6%5D%5Bdata%5D=6&columns%5B6%5D%5Bname%5D=&columns%5B6%5D%5Bsearchable%5D=true&columns%5B6%5D%5Borderable%5D=true&columns%5B6%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B6%5D%5Bsearch%5D%5Bregex%5D=false&columns%5B7%5D%5Bdata%5D=7&columns%5B7%5D%5Bname%5D=&columns%5B7%5D%5Bsearchable%5D=true&columns%5B7%5D%5Borderable%5D=true&columns%5B7%5D%5Bsearch%5D%5Bvalue%5D=&columns%5B7%5D%5Bsearch%5D%5Bregex%5D=false&order%5B0%5D%5Bcolumn%5D=2&order%5B0%5D%5Bdir%5D=asc&start=0&length=10&search%5Bvalue%5D=';
    final url = baseUrl + cref;
    final response = await get(
      Uri.parse(url),
    );

    bool isCref = response.body.contains(cref);
    bool isName = response.body.contains('Fabiano');
  }

  static SessionUser _firebaseUserToSessionUser(User user,
      [String? name, String? cref]) {
    return SessionUser(
        id: user.uid,
        name: name ?? user.displayName ?? user.email!.split('@')[0],
        email: user.email!,
        imageURL: user.photoURL ?? 'assets/images/avatar.png',
        personal: PersonalModel(cref: cref ?? ''));
  }
}
