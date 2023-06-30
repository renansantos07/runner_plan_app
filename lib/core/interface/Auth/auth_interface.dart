import 'package:runner_plan_app/core/model/session_user_model.dart';
import 'package:runner_plan_app/core/service/auth/auth_service.dart';

abstract class AuthInterface {
  SessionUser? get sessionUser;

  Stream<SessionUser?> get userChanges;

  Future<void> signup(
    String name,
    String email,
    String password,
  );

  Future<void> login(
    String email,
    String password,
  );

  Future<void> logout();

  factory AuthInterface() {
    // return AuthMockService();
    return AuthService();
  }
}
