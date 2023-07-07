import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runner_plan_app/components/common/user_image.dart';
import 'package:runner_plan_app/core/app_routes.dart';
import 'package:runner_plan_app/core/interface/Auth/auth_interface.dart';
import 'package:runner_plan_app/core/model/common/session_user_model.dart';
import 'package:runner_plan_app/core/service/user/user_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserProvider>(context).user;

    return Drawer(
      width: MediaQuery.of(context).size.width,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.primary),
            width: double.infinity,
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(bottom: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Builder(
                          builder: (context) => IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Theme.of(context).colorScheme.onPrimary,
                              size: 25,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  UserImage(
                    imageUrl: _user.imageURL,
                    width: 150,
                    height: 150,
                  ),
                  Text(
                    '${_user.name} ${_user.surname}',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                  Text(
                    _user.email,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            title: Text(
              "Início",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            title: Text(
              "Perfil",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.Profile,
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.group,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            title: Text(
              "Atletas",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(
              Icons.calendar_month,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            title: Text(
              "Provas",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(
              Icons.rocket_launch,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            title: Text(
              "Metas",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            title: Text(
              "Sair",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            onTap: () {
              AuthInterface().logout();
            },
          ),
        ],
      ),
    );
  }
}
