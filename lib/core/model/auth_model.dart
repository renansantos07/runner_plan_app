enum AuthMode { Signup, Login }

class AuthModel {
  String name = '';
  String email = '';
  String password = '';
  String confirm_password = '';
  AuthMode _mode = AuthMode.Login;

  bool get isLogin {
    return _mode == AuthMode.Login;
  }

  bool get isSignup {
    return _mode == AuthMode.Signup;
  }

  void toggleAuthMode() {
    _mode = isLogin ? AuthMode.Signup : AuthMode.Login;
  }
}
