import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:runner_plan_app/util/validators/common_validators.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({
    Key? key,
    this.email = '',
    required this.onSendEmail,
  }) : super(key: key);

  String email = '';
  final void Function(String email) onSendEmail;

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formPassKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String _email = widget.email;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 300,
        padding: EdgeInsets.all(20),
        child: Center(
          child: Form(
            key: _formPassKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Esqueceu sua senha?',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(height: 15),
                const Text(
                    'Será enviado um e-mail com o link para você criar uma nova senha! Para continuar digite o e-mail cadastrado!'),
                TextFormField(
                    initialValue: widget.email,
                    onChanged: (email) => _email = email,
                    decoration: const InputDecoration(labelText: 'E-mail'),
                    validator: (_email) {
                      final email = _email ?? '';
                      if (!CommonValidators().isEmail(email)) {
                        return 'E-mail informado não é válido.';
                      }

                      return null;
                    }),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.primary)),
                    onPressed: () {
                      final isValid =
                          _formPassKey.currentState?.validate() ?? false;

                      if (isValid) {
                        widget.onSendEmail(_email);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(
                      'Sim',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
