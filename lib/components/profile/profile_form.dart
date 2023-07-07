import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runner_plan_app/core/exception/custom_firebase_exception.dart';
import 'package:runner_plan_app/core/interface/user/user_interface.dart';
import 'package:runner_plan_app/core/model/common/session_user_model.dart';
import 'package:runner_plan_app/core/model/personal/personal_modal.dart';
import 'package:runner_plan_app/core/service/user/user_provider.dart';
import 'package:runner_plan_app/pages/common/loading_page.dart';
import 'package:runner_plan_app/util/validators/common_validators.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  ProfileFormState createState() {
    return ProfileFormState();
  }
}

class ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late SessionUser _formData;
  bool _isLoading = true;

  @override
  initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    _formData =
        await Provider.of<UserProvider>(context, listen: false).loadUser();

    setState(() {
      _isLoading = false;
    });
  }

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

  Future<void> saveProfile() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<UserProvider>(context, listen: false)
            .updateUser(_formData);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Dados atualizado com sucesso!"),
            backgroundColor: Colors.green,
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
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator()
        : Padding(
            padding: EdgeInsets.all(25),
            child: Form(
              key: _formKey,
              child: Column(children: [
                TextFormField(
                  key: const ValueKey('name'),
                  initialValue: _formData.name,
                  onChanged: (name) => _formData.name = name,
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (_name) {
                    final name = _name ?? '';
                    if (name.trim().length < 5) {
                      return 'Nome deve ter no mínimo 5 caracteres.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
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
                const SizedBox(height: 15),
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
                )
              ]),
            ),
          );
  }
}
