import 'package:flutter/material.dart';
import 'package:runner_plan_app/core/interface/Auth/auth_interface.dart';
import 'package:runner_plan_app/core/model/common/session_user_model.dart';
import 'package:runner_plan_app/firebase_options.dart';
import 'package:runner_plan_app/pages/auth/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:runner_plan_app/pages/dashboard/dashboard_page.dart';
import 'package:runner_plan_app/pages/home/home_page.dart';
import 'package:runner_plan_app/pages/common/loading_page.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> init(BuildContext context) async {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }

    return FutureBuilder(
      future: init(context),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingPage();
        } else {
          return StreamBuilder<SessionUser?>(
            stream: AuthInterface().userChanges,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingPage();
              } else {
                return snapshot.hasData ? HomePage() : AuthPage();
              }
            },
          );
        }
      },
    );
  }
}
