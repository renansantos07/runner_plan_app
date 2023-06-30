import 'package:flutter/material.dart';
import 'package:runner_plan_app/core/interface/Auth/auth_interface.dart';
import 'package:runner_plan_app/core/model/session_user_model.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SessionUser _sessionUser = AuthInterface().sessionUser!;

    return Drawer(
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(
            // // color: Theme.of(context).primaryColor,
            // gradient: LinearGradient(
            //   colors: [
            //     Theme.of(context).primaryColor,
            //     Theme.of(context).colorScheme.primaryContainer,
            //   ],
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            // ),
            ),
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 100,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 40),
              alignment: Alignment.bottomRight,
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(_sessionUser.imageURL),
                      )
                    ],
                  ),
                ),
                title: Text(
                  _sessionUser.name,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
                subtitle: Text(
                  _sessionUser.email,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
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
      ),
    );
  }
}
