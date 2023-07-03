import 'package:flutter/material.dart';
import 'package:runner_plan_app/components/common/user_image.dart';
import 'package:runner_plan_app/core/app_routes.dart';
import 'package:runner_plan_app/core/interface/Auth/auth_interface.dart';
import 'package:runner_plan_app/core/model/common/session_user_model.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SessionUser _sessionUser = AuthInterface().sessionUser!;

    return Drawer(
      width: MediaQuery.of(context).size.width,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.primary),
            height: 200,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 50),
            alignment: Alignment.topRight,
            child: ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  UserImage(
                    imageUrl: _sessionUser.imageURL,
                    width: 50,
                    height: 50,
                  ),
                ],
              ),
              title: Text(
                _sessionUser.name,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
              subtitle: Text(
                _sessionUser.email,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
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
