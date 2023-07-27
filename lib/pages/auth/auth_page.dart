import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:runner_plan_app/components/auth/auth_form.dart';
import 'package:runner_plan_app/core/exception/custom_firebase_exception.dart';
import 'package:runner_plan_app/core/interface/Auth/auth_interface.dart';
import 'package:runner_plan_app/core/model/common/auth_model.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  void _showError(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ops...'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

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
        await AuthInterface().signupPersonal(authModel);
      }
    } on CustomFirebaseException catch (error) {
      _showError(error.toString());
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      _showError('Ocorreu um erro inesperado!');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _forgetPassword(String email) async {
    try {
      await AuthInterface().forgetPassword(email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("E-mail enviado com sucesso!"),
          backgroundColor: Theme.of(context).colorScheme.primary,
          duration: const Duration(seconds: 4),
        ),
      );
    } on CustomFirebaseException catch (error) {
      _showError(error.toString());
    } catch (error) {
      _showError('Ocorreu um erro inesperado!');
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
                onForgetPassWord: _forgetPassword,
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
