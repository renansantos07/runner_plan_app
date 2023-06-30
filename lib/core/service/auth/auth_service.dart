import 'package:firebase_auth/firebase_auth.dart';
import 'package:runner_plan_app/core/interface/Auth/auth_interface.dart';
import 'package:runner_plan_app/core/model/session_user_model.dart';

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
    final authInstance = FirebaseAuth.instance;
    UserCredential credential = await authInstance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    print(credential ?? null);
  }

  @override
  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> signup(String name, String email, String password) async {
    final authInstance = FirebaseAuth.instance;
    UserCredential credential =
        await authInstance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential != null) {
      // 2. atualizar os atributos do usuário
      await credential.user?.sendEmailVerification();
      await credential.user?.updateDisplayName(name);
    }
  }

  static SessionUser _firebaseUserToSessionUser(User user, [String? name]) {
    return SessionUser(
      id: user.uid,
      name: name ?? user.displayName ?? user.email!.split('@')[0],
      email: user.email!,
      imageURL: user.photoURL ?? 'assets/images/avatar.png',
    );
  }
}
