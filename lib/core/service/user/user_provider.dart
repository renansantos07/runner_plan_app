import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:runner_plan_app/core/interface/Auth/auth_interface.dart';
import 'package:runner_plan_app/core/interface/user/user_interface.dart';
import 'package:runner_plan_app/core/model/common/session_user_model.dart';

class UserProvider with ChangeNotifier {
  SessionUser _user = AuthInterface().sessionUser!;

  SessionUser get user {
    return _user;
  }

  String get userId {
    return _user.id;
  }

  Future<SessionUser> loadUser() async {
    final responseUser = await UserInterface().getUser(userId);
    _user = responseUser;

    notifyListeners();
    return responseUser;
  }

  Future<void> updateUser(SessionUser user) async {
    final responseUser = await UserInterface().updateUser(user);

    _user = responseUser;

    notifyListeners();
  }
}
