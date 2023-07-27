import 'package:flutter/material.dart';
import 'package:runner_plan_app/core/model/common/auth_model.dart';
import 'package:runner_plan_app/util/validators/PortuguesePasswordValidators.dart';
import 'package:runner_plan_app/util/validators/common_validators.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import '../common/forget_password.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthModel) onSubmit;
  final void Function(String email) onForgetPassWord;

  const AuthForm({key, required this.onSubmit, required this.onForgetPassWord});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FlutterPwValidatorState> validatorKey =
      GlobalKey<FlutterPwValidatorState>();
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthModel();
  bool _passwordVisible = true;
  bool _passwordIsStrong = false;

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      widget.onSubmit(_formData);
    }
  }

  void _forgetPassword() {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return ForgetPassword(
          email: _formData.email,
          onSendEmail: (email) => widget.onForgetPassWord(email),
        );
      },
    );
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
            if (_formData.isSignup)
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  key: const ValueKey('surname'),
                  initialValue: _formData.surname,
                  onChanged: (surname) => _formData.surname = surname,
                  decoration: const InputDecoration(labelText: 'Sobrenome'),
                  validator: (_surname) {
                    final surname = _surname ?? '';
                    if (surname.trim().isEmpty) {
                      return 'Sobrenome deve ser preenchido.';
                    }
                    return null;
                  },
                ),
              ),
            if (_formData.isSignup)
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  key: const ValueKey('cref'),
                  initialValue: _formData.cref,
                  onChanged: (cref) => _formData.cref = cref,
                  decoration: const InputDecoration(
                      labelText: 'CREF', hintText: "123456-G/SP"),
                  validator: (_cref) {
                    final cref = _cref ?? '';
                    if (cref.trim().length < 11) {
                      return 'Cref deve ter no mínimo 11 caracteres.';
                    }
                    return null;
                  },
                ),
              ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              key: ValueKey('email'),
              initialValue: _formData.email,
              onChanged: (email) => _formData.email = email,
              decoration: InputDecoration(labelText: 'E-mail'),
              validator: (_email) {
                final email = _email ?? '';
                if (!CommonValidators().isEmail(email)) {
                  return 'E-mail informado não é válido.';
                }

                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              key: ValueKey('password'),
              // initialValue: _formData.password,
              controller: passwordController,
              onChanged: (password) => _formData.password = password,
              obscureText: _passwordVisible,
              decoration: InputDecoration(
                labelText: 'Senha',
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
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
                if (_formData.isSignup && !_passwordIsStrong) {
                  return 'Senha muito fraca.';
                }

                if (_formData.isLogin && password.trim().isEmpty) {
                  return 'Senha deve ser preenchida.';
                }

                return null;
              },
            ),
            if (_formData.isLogin)
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _forgetPassword,
                  child: Text(
                    "Esqueci minha senha",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
            if (_formData.isSignup)
              const SizedBox(
                height: 5,
              ),
            if (_formData.isSignup)
              Align(
                alignment: Alignment.centerLeft,
                child: FlutterPwValidator(
                  key: validatorKey,
                  controller: passwordController,
                  minLength: 8,
                  uppercaseCharCount: 1,
                  lowercaseCharCount: 1,
                  numericCharCount: 1,
                  specialCharCount: 1,
                  width: 400,
                  height: 180,
                  strings: PortugueseStrings(),
                  onSuccess: () {
                    setState(() {
                      _passwordIsStrong = true;
                    });
                  },
                  onFail: () {
                    setState(() {
                      _passwordIsStrong = false;
                    });
                  },
                ),
              ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                child: Text(_formData.isLogin ? 'Entrar' : 'Cadastrar'),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
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
            ),
          ],
        ),
      ),
    );
  }
}
