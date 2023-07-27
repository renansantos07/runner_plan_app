import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runner_plan_app/components/common/show_alert_dialog.dart';
import 'package:runner_plan_app/core/exception/custom_firebase_exception.dart';
import 'package:runner_plan_app/core/interface/Auth/auth_interface.dart';
import 'package:runner_plan_app/core/model/common/auth_model.dart';
import 'package:runner_plan_app/core/model/common/session_user_model.dart';
import 'package:runner_plan_app/core/service/user/user_provider.dart';

import '../../util/validators/common_validators.dart';

class newAthleteForm extends StatefulWidget {
  const newAthleteForm({Key? key}) : super(key: key);

  @override
  State<newAthleteForm> createState() => _newAthleteFormState();
}

class _newAthleteFormState extends State<newAthleteForm> {
  final _formKey = GlobalKey<FormState>();

  AuthModel _formData = AuthModel();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final snack = ScaffoldMessenger.of(context);

    Future<void> _onSubmit() async {
      final isValid = _formKey.currentState?.validate() ?? false;
      if (isValid) {
        setState(() {
          _isLoading = true;
        });
        try {
          await AuthInterface().signupAthlete(_formData);

          snack.showSnackBar(
            const SnackBar(
              content: Text("Atleta criado com sucesso!"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 4),
            ),
          );

          _formData = AuthModel();
          _formKey.currentState?.reset();
        } on CustomFirebaseException catch (error) {
          ShowAlertDialog.of(context).show(
            message: error.toString(),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Fechar'),
              ),
            ],
          );
        } catch (error) {
          ShowAlertDialog.of(context).show(
            message: 'Ocorreu um erro inesperado!',
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Fechar'),
              ),
            ],
          );
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }

    if (_isLoading) {
      return const Center(child: RefreshProgressIndicator());
    } else {
      return Padding(
        padding: EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Column(children: [
            const ListTile(
              leading: Icon(Icons.person_add),
              title: Text('Dados do Atleta'),
            ),
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
            const SizedBox(height: 10),
            TextFormField(
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
            const SizedBox(height: 10),
            TextFormField(
              key: ValueKey('email'),
              initialValue: _formData.email,
              onChanged: (email) => _formData.email = email,
              decoration: const InputDecoration(labelText: 'E-mail'),
              validator: (_email) {
                final email = _email ?? '';
                if (!CommonValidators().isEmail(email)) {
                  return 'E-mail informado não é válido.';
                }

                return null;
              },
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onSubmit,
                child: Text('Cadastrar'),
              ),
            ),
          ]),
        ),
      );
    }
  }
}
