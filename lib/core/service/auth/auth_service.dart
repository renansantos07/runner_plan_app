import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:runner_plan_app/core/exception/custom_firebase_exception.dart';
import 'package:runner_plan_app/core/interface/Auth/auth_interface.dart';
import 'package:runner_plan_app/core/interface/user/user_interface.dart';
import 'package:runner_plan_app/core/model/common/auth_model.dart';
import 'package:runner_plan_app/core/model/common/session_user_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:runner_plan_app/core/model/personal/personal_modal.dart';

class AuthService implements AuthInterface {
  static SessionUser? _sessionUser;
  static final _userStream = Stream<SessionUser?>.multi(
    (controller) async {
      final authChanges = FirebaseAuth.instance.authStateChanges();
      await for (final user in authChanges) {
        _sessionUser =
            user == null ? null : await _firebaseUserToSessionUser(user);
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
  Future<void> signupAthlete(AuthModel authModel) async {
    authModel.password = _generatePassword();
    UserCredential credential = await signup(authModel);

    final userAthlete =
        await _firebaseUserToSessionUser(credential.user!, authModel);
    await UserInterface().saveAthleteUser(userAthlete);
  }

  @override
  Future<void> signupPersonal(AuthModel authModel) async {
    UserCredential credential = await signup(authModel);

    _sessionUser =
        await _firebaseUserToSessionUser(credential.user!, authModel);
    await UserInterface().savePersonalUser(_sessionUser!);
  }

  @override
  Future<UserCredential> signup(AuthModel authModel) async {
    try {
      final signup = await Firebase.initializeApp(
        name: 'userSignup',
        options: Firebase.app().options,
      );
      final authInstance = FirebaseAuth.instanceFor(app: signup);

      UserCredential credential =
          await authInstance.createUserWithEmailAndPassword(
        email: authModel.email,
        password: authModel.password,
      );

      if (credential.user != null) {
        // 2. atualizar os atributos do usuário
        await credential.user?.sendEmailVerification();
        await credential.user?.updateDisplayName(authModel.name);

        // 2.5 fazer o login do usuário
        // await login(authModel.email, authModel.password);

        // 3. salvar usuário no banco de dados (opcional)
      }

      await signup.delete();
      return credential;
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

  static Future<SessionUser> _firebaseUserToSessionUser(User user,
      [AuthModel? authModel]) async {
    SessionUser sessionUser;

    if (authModel == null) {
      sessionUser = await UserInterface().getUser(user.uid);
    } else {
      final name = authModel != null
          ? authModel.name
          : user.displayName ?? user.email!.split('@')[0];

      sessionUser = SessionUser(
          id: user.uid,
          name: name,
          surname: authModel != null ? authModel.surname : '',
          email: user.email!,
          cref: authModel.cref,
          imageURL: user.photoURL ?? 'assets/images/avatar.png');
    }

    return sessionUser;
  }

  String _generatePassword({
    bool letter = true,
    bool isNumber = true,
    bool isSpecial = true,
  }) {
    const length = 20;
    const letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
    const letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const number = '0123456789';
    const special = '@#%^*>\$@?/[]=+';

    String chars = "";
    if (letter) chars += '$letterLowerCase$letterUpperCase';
    if (isNumber) chars += '$number';
    if (isSpecial) chars += '$special';

    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join('');
  }
}
