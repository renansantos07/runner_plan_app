import 'package:flutter/material.dart';
import 'package:runner_plan_app/core/model/auth_model.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthModel) onSubmit;

  const AuthForm({
    key,
    required this.onSubmit,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthModel();
  bool _passwordVisible = true;
  bool _confirmPasswordVisible = true;

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      widget.onSubmit(_formData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const FlutterLogo(size: 100),
            const SizedBox(height: 30),
            if (_formData.isSignup)
              TextFormField(
                key: const ValueKey('name'),
                initialValue: _formData.name,
                onChanged: (name) => _formData.name = name,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (_name) {
                  final name = _name ?? '';
                  if (name.trim().length < 5) {
                    return 'Nome deve ter no mínimo 5 caracteres.';
                  }
                  return null;
                },
              ),
            TextFormField(
              key: ValueKey('email'),
              initialValue: _formData.email,
              onChanged: (email) => _formData.email = email,
              decoration: InputDecoration(labelText: 'E-mail'),
              validator: (_email) {
                final email = _email ?? '';
                if (!email.contains('@')) {
                  return 'E-mail informado não é válido.';
                }
                return null;
              },
            ),
            TextFormField(
              key: ValueKey('password'),
              initialValue: _formData.password,
              onChanged: (password) => _formData.password = password,
              obscureText: _passwordVisible,
              decoration: InputDecoration(
                labelText: 'Senha',
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
              validator: (_password) {
                final password = _password ?? '';
                if (_formData.isSignup && password.length < 6) {
                  return 'Senha deve ter no mínimo 6 caracteres.';
                }
                return null;
              },
            ),
            if (_formData.isSignup)
              TextFormField(
                key: ValueKey('confirm_password'),
                initialValue: _formData.confirm_password,
                onChanged: (confirm_password) =>
                    _formData.confirm_password = confirm_password,
                obscureText: _confirmPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Confirmação de senha',
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _confirmPasswordVisible = !_confirmPasswordVisible;
                      });
                    },
                  ),
                ),
                validator: (_confirm_password) {
                  final confirm_password = _confirm_password ?? '';
                  if (confirm_password.trim().length < 6) {
                    return 'Senha deve ter no mínimo 6 caracteres.';
                  }

                  if (confirm_password.trim() != _formData.password.trim()) {
                    return 'Senhas não estão iguais.';
                  }
                  return null;
                },
              ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _submit,
              child: Text(_formData.isLogin ? 'Entrar' : 'Cadastrar'),
            ),
            TextButton(
              child: Text(
                _formData.isLogin
                    ? 'Criar uma nova conta?'
                    : 'Já possui conta?',
              ),
              onPressed: () {
                setState(() {
                  _formData.toggleAuthMode();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
