import 'package:flutter/material.dart';
import 'package:runner_plan_app/components/auth_form.dart';
import 'package:runner_plan_app/core/interface/Auth/auth_interface.dart';
import 'package:runner_plan_app/core/model/auth_model.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  Future<void> _handleSubmit(AuthModel authModel) async {
    try {
      setState(() {
        _isLoading = true;
      });

      if (authModel.isLogin) {
        // Login
        await AuthInterface().login(
          authModel.email,
          authModel.password,
        );
      } else {
        // Signup
        await AuthInterface().signup(
          authModel.name,
          authModel.email,
          authModel.password,
        );
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: AuthForm(
                onSubmit: _handleSubmit,
              ),
            ),
          ),
          if (_isLoading)
            Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
