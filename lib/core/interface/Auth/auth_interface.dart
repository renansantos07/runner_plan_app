import 'package:runner_plan_app/core/model/common/session_user_model.dart';
import 'package:runner_plan_app/core/service/auth/auth_service.dart';

abstract class AuthInterface {
  SessionUser? get sessionUser;

  Stream<SessionUser?> get userChanges;

  Future<void> signup(
    String name,
    String cref,
    String email,
    String password,
  );

  Future<void> login(
    String email,
    String password,
  );

  Future<void> logout();
  Future<void> forgetPassword(String email);
  Future<void> getCref(String? cref);

  factory AuthInterface() {
    // return AuthMockService();
    return AuthService();
  }
}
