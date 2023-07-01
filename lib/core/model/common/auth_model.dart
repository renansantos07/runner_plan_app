enum AuthMode { Signup, Login }

class AuthModel {
  String name = '';
  String cref = '';
  String email = '';
  String password = '';
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
